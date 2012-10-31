require_relative "../proprietario"
require_relative "../database_test"
class ProprietarioDAO
  attr_accessor :proprietario , :existentes ,:existentes_id
  def initialize
    @proprietario = Proprietario.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
    @existentes = {}
    @existentes_id = {}
    rs = @con.query("SELECT IdProprietario,NmProprietario FROM Proprietario")
    rs.each_hash do |row|
      nome_proprietario = row['NmProprietario']
      id_proprietario = row['IdProprietario']
      @existentes[nome_proprietario] = true
      @existentes_id[nome_proprietario] = id_proprietario
    end
  end

  def insert
    if !@existentes[@proprietario.nm_proprietario]
      puts "insert into Proprietario(NmProprietario) values('#{@proprietario.nm_proprietario}')"
      @con.query("insert into Proprietario(NmProprietario) values('#{@proprietario.nm_proprietario}')")
      @existentes[@proprietario.nm_proprietario] = true
      rs = @con.query("SELECT IdProprietario FROM Proprietario where NmProprietario = '#{@proprietario.nm_proprietario}'")
      rs.each_hash do |row|
        id_proprietario = row['IdProprietario']
        @existentes_id[@proprietario.nm_proprietario] = id_proprietario
      end
      else puts "Proprietario ja cadastrado."
    end
  end

  def get_proprietario_id()
    @existentes_id[@proprietario.nm_proprietario]
  end

end