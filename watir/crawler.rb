# encoding: utf-8
require 'rubygems'
#require 'logger'
require 'watir-webdriver'
require_relative "race_day"
require_relative "dao/hipodromo_dao"
require_relative "dao/reuniao_dao"
require_relative "dao/pareo_dao"
require_relative "dao/item_pareo_dao"
require_relative "dao/joquei_dao"
require_relative "dao/montaria_dao"
require_relative "dao/proprietario_dao"
require_relative "dao/treinador_dao"
require_relative "database_test"

class Crawler

  attr_accessor :last_date, :url ,:hipodromo_dao, :pareo_dao, :montaria_dao, :reuniao_dao, :joquei_dao, :proprietario_dao, :treinador_dao, :database

  @hipodromo_dao = HipodromoDAO.new
  #@hipodromo_dao.hipodromo.nm_hipodromo= "HIPODROMO TESTE"

  @reuniao_dao = ReuniaoDAO.new
  @pareo_dao = PareoDAO.new
  @montaria_dao = MontariaDAO.new
  @joquei_dao = JoqueiDAO.new
  @proprietario_dao = ProprietarioDAO.new
  @treinador_dao = TreinadorDAO.new
  @item_pareo_dao = ItemPareoDAO.new

  browser = Watir::Browser.new :ff
  puts browser.class
#  browser.set_options(:visible => false)
  #browser.log = Logger.new "crawler.log"
  race_day = RaceDay.new
  # a linha abaixo é para começar de uma data especifica no passado.
  race_day.datas << "22102012"

  race_date = race_day.next_date
  while Date.strptime(race_date,"%d%m%Y") > Date.strptime("08102012","%d%m%Y") do
    browser.goto "http://www.jcb.com.br/conteudo/Reuniao?dia=#{race_date}&idReuniao=0"

    #puts browser.url

    # ARMAZENA O LINK DE CADA PAREO. a regex é para strings que comecem com digitos.
    #links = browser.links(:text => /1/).collect { |link| link.href }
    links = browser.links(:text => /\A\d+/).collect { |link| link.href }

    # ITERA SOBRE TODOS OS PAREOS DA REUNIAO
    links.each do |link|
      #puts link + "\n"
      browser.goto link

      # O motivo do sleep é pelas condições de corrida, recursos assincronos de ajax e javascript. é preciso dar tempo da pagina carregar completamente.
      sleep 5

      #puts "Nome do Hipodromo:"
      p browser.h1.text.gsub(/Ã|Á/,"A").scan(/GAVEA|CRISTAL|CIDADE JARDIM|TARUMA/).first
      @hipodromo_dao.hipodromo.nm_hipodromo= browser.h1.text.gsub(/Ã|Á/,"A").scan(/GAVEA|CRISTAL|CIDADE JARDIM|TARUMA/).first
      if @hipodromo_dao.hipodromo.nm_hipodromo.nil?
        break
      end
      # Os Hipodromos foram cadastrados manualmente pois sao poucos  e o resto depende deles
      #@hipodromo_dao.insert
      # A reuniao somente deve ser inserida no banco se for o primeiro páreo
      if browser.a(:class => 'current').span.text.to_s.eql?"1"
        @reuniao_dao.reuniao.id_hipodromo=(@hipodromo_dao.hipodromo.nm_hipodromo)
        @reuniao_dao.reuniao.nm_reuniao= browser.h1.text
        @reuniao_dao.reuniao.dt_reuniao= Date.strptime(race_date,"%d%m%Y")
        @reuniao_dao.reuniao.num_reuniao= browser.h1.text.scan(/\d+/).first
        @reuniao_dao.reuniao.mvto_geral_apostas= browser.div(:id => 'MainContent_upDadosReuniao').lis[5].text.to_s
        @reuniao_dao.insert
      end


      @pareo_dao.pareo.distancia_pista= browser.span(:id => 'MainContent_lblFechadoDistancia').text.to_s.scan(/\d+/).first
      @pareo_dao.pareo.tp_pista= browser.span(:id => 'MainContent_lblFechadoPista').text.to_s
      # Buscando chamado do pareo, se houver
      tag_chamado = browser.div(:class => 'tab1').ps[0]
      if (!tag_chamado.nil? && (tag_chamado.text.to_s.length > "Ver resultado completo".length))
        @pareo_dao.pareo.nm_pareo= tag_chamado.text.to_s
        else @pareo_dao.pareo.nm_pareo= nil
      end
      # nm_pareo por enquanto vai ficar nulo.
      #@pareo_dao.pareo.nm_pareo= nil
      @pareo_dao.pareo.num_pareo= browser.a(:class => 'current').span.text.to_s
      @pareo_dao.pareo.dt_pareo= @reuniao_dao.reuniao.dt_reuniao
      #puts  "id_hipodromo = " + @reuniao_dao.reuniao.id_hipodromo.to_s + "  dt_reuniao = " + @reuniao_dao.reuniao.dt_reuniao.to_s
      @pareo_dao.set_reuniao(@reuniao_dao.reuniao.id_hipodromo,@reuniao_dao.reuniao.dt_reuniao)
      @pareo_dao.insert

      tabelas = browser.tables(:id, 'MainContent_gvAnimaisFechado').collect
      # essa solução abaixo ja foi substituida por outra => tab.delete_at(0)
      # o boolean executar é para usar as regras da expressao regular na linhade cabeçalho da tabela, nao vai funcionar.
      executar = true
      tabelas.each do |tabela|
        tab = tabela.to_a
        tab.delete_at(0)
        posicao = 0
        tab.each {|linha| row = linha.to_a
        if executar
          if !row[0].to_s.scan(/\d+|--|NC/).first.eql?("NC")
            posicao = posicao  + 1
            @item_pareo_dao.item_pareo.pos_montaria= posicao
            else @item_pareo_dao.item_pareo.pos_montaria= "NC"
          end
          #@item_pareo_dao.item_pareo.pos_montaria= row[0].to_s.scan(/\d+|--|NC/).first
          @item_pareo_dao.item_pareo.num_montaria= row[3].to_s.gsub(/'/,"*")
          @item_pareo_dao.item_pareo.peso_montaria= row[4].to_s.gsub(/\((D|A|A1|L|L1|L\-A|L1\-A|L1\-A1|P1|P2|URU|USA|IRE|ARG|PR|RJ|SP|RS)\)/,"").gsub(/\(Est\.|\(EST|\(EST\.|\(Est/,"(000").scan(/\d+/).first
          @item_pareo_dao.item_pareo.peso_joquei= row[4].to_s.scan(/\d+/).last

          @proprietario_dao.proprietario.nm_proprietario=(row[7].to_s.gsub(/'/,""))

          if row[9].nil?
            rateio = "null"
            else rateio = row[9].to_s.to_f
          end
          @item_pareo_dao.item_pareo.rateio_final= rateio
          idade = row[5].to_s.scan(/\d/).first
          if idade.nil?
            idade = "0"
          end
          @item_pareo_dao.item_pareo.idade_montaria= idade
          @proprietario_dao.insert

          @treinador_dao.treinador.nm_treinador=(row[8].to_s.gsub(/'/,""))
          @treinador_dao.insert
          #  \w+(\s*\w+\s)*\(
          @montaria_dao.montaria.nm_montaria=(row[4].to_s.gsub(/\((D|A|A1|L|L1|L\-A|L1\-A|L1\-A1|P1|P2|URU|USA|IRE|ARG|PR|RJ|SP|RS)\)/,"").gsub(/\(Est\.|\(EST|\(EST\.|\(Est/,"(000").scan(/\A\D+\s\(/)[0].gsub(/\)\s|\s\(|\)|\(/,"").gsub(/'/,"").gsub(/\s\Z/,"").gsub(/\A\s/,""))

          @montaria_dao.montaria.tp_sexo=(row[5].scan(/\/\D+\//).first.gsub(/\/|\s/,""))
          @montaria_dao.montaria.idade=  idade
          @montaria_dao.insert

          @joquei_dao.joquei.nm_joquei=(row[4].gsub(/\((D|A|A1|L|L1|L\-A|L1\-A|L1\-A1|P1|P2|URU|USA|IRE|ARG|PR|RJ|SP|RS)\)/,"").scan(/\)\D+\(|\)\D+\s/).first.gsub(/\)\s|\s\(|\)|\(/,"").gsub(/'/,"").gsub(/\s\Z/,"").gsub(/\A\s/,""))
          @joquei_dao.insert

          @item_pareo_dao.item_pareo.id_proprietario = @proprietario_dao.get_proprietario_id
          @item_pareo_dao.item_pareo.id_treinador = @treinador_dao.get_treinador_id
          @item_pareo_dao.item_pareo.id_joquei = @joquei_dao.get_joquei_id
          @item_pareo_dao.item_pareo.id_montaria = @montaria_dao.get_montaria_id
          @item_pareo_dao.item_pareo.id_pareo = @pareo_dao.get_pareo_id
          @item_pareo_dao.insert

        end
        }
        executar = true
      end
    end
    race_date = race_day.next_date
  end
end