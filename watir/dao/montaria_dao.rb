# encoding: utf-8
require_relative "../montaria"
require_relative "../database_test"

class MontariaDAO
  attr_accessor :montaria ,:existentes, :existentes_id
  def initialize
    @montaria = Montaria.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
    @existentes = {}
    @existentes_id = {}
    rs = @con.query("SELECT IdMontaria,NmMontaria FROM Montaria")
    rs.each_hash do |row|
      nome_montaria = row['NmMontaria']
      id_montaria = row['IdMontaria']
      @existentes[nome_montaria] = true
      @existentes_id[nome_montaria] = id_montaria
    end
  end

  def insert
    if @existentes[@montaria.nm_montaria]
      puts "Montaria já cadastrada."
    else
      puts "INSERT INTO MONTARIA(NmMontaria,TpSexo,Idade) VALUES('#{@montaria.nm_montaria}',#{@montaria.tp_sexo},#{@montaria.idade})"
      @con.query("INSERT INTO MONTARIA(NmMontaria,TpSexo,Idade) VALUES('#{@montaria.nm_montaria}',#{@montaria.tp_sexo},#{@montaria.idade})")
      @existentes[@montaria.nm_montaria] = true
      rs = @con.query("SELECT IdMontaria FROM Montaria where NmMontaria = '#{@montaria.nm_montaria}'")
      rs.each_hash do |row|
        id_montaria = row['IdMontaria']
        @existentes_id[@montaria.nm_montaria] = id_montaria
      end
    end
  end

  def get_montaria_id()
    existentes_id[@montaria.nm_montaria]
  end

end