# encoding: utf-8
require_relative "../../watir/item_pareo"
require_relative "../database_test"

class ItemPareoDAO
  attr_accessor :item_pareo

  def initialize
    @item_pareo = ItemPareo.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
  end

  def insert
    puts "insert into ItemPareo(IdMontaria,IdJoquei,IdPareo,IdProprietario,IdTreinador,IdadeMontaria,PesoMontaria,PesoJoquei,NumMontaria,PosMontaria,RateioFinal) values(#{@item_pareo.id_montaria},#{@item_pareo.id_joquei},#{@item_pareo.id_pareo},#{@item_pareo.id_proprietario},#{@item_pareo.id_treinador},#{@item_pareo.idade_montaria},#{@item_pareo.peso_montaria},#{@item_pareo.peso_joquei},'#{@item_pareo.num_montaria}','#{@item_pareo.pos_montaria}',#{@item_pareo.rateio_final})"
    @con.query("insert into ItemPareo(IdMontaria,IdJoquei,IdPareo,IdProprietario,IdTreinador,IdadeMontaria,PesoMontaria,PesoJoquei,NumMontaria,PosMontaria,RateioFinal) values(#{@item_pareo.id_montaria},#{@item_pareo.id_joquei},#{@item_pareo.id_pareo},#{@item_pareo.id_proprietario},#{@item_pareo.id_treinador},#{@item_pareo.idade_montaria},#{@item_pareo.peso_montaria},#{@item_pareo.peso_joquei},'#{@item_pareo.num_montaria}','#{@item_pareo.pos_montaria}',#{@item_pareo.rateio_final})")
  end

end