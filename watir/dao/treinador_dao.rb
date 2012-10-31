require_relative "../treinador"
require_relative "../database_test"

class TreinadorDAO
  attr_accessor :treinador ,:existentes ,:existentes_id
  def initialize
    @treinador = Treinador.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
    @existentes = {}
    @existentes_id = {}
    rs = @con.query("SELECT IdTreinador,NmTreinador FROM Treinador")
    rs.each_hash do |row|
      nome_treinador = row['NmTreinador']
      id_treinador = row['IdTreinador']
      @existentes[nome_treinador] = true
      @existentes_id[nome_treinador] = id_treinador
    end
  end

  def insert
    if !@existentes[@treinador.nm_treinador]
      puts "insert into Treinador(NmTreinador) values('#{@treinador.nm_treinador}')"
      @con.query("insert into Treinador(NmTreinador) values('#{@treinador.nm_treinador}')")
      @existentes[@treinador.nm_treinador] = true
      rs = @con.query("SELECT IdTreinador FROM Treinador where NmTreinador = '#{@treinador.nm_treinador}'")
      rs.each_hash do |row|
        id_treinador = row['IdTreinador']
        @existentes_id[@treinador.nm_treinador] = id_treinador
      end
    else puts "Treinador ja cadastrado."
    end
  end

  def get_treinador_id()
    @existentes_id[@treinador.nm_treinador]
  end

end