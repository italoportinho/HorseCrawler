# encoding: utf-8
require_relative "../pareo"
require_relative "../database_test"
class PareoDAO
  attr_accessor :pareo
  def initialize
    @pareo = Pareo.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
  end

  def insert
    puts "INSERT INTO Pareo(NmPareo,DtPareo,TpPista,DistanciaPista,IdReuniao,NumPareo) VALUES('#{@pareo.nm_pareo}','#{@pareo.dt_pareo}','#{@pareo.tp_pista}',#{@pareo.distancia_pista},#{@pareo.id_reuniao},#{@pareo.num_pareo})"
    @con.query("INSERT INTO Pareo(NmPareo,DtPareo,TpPista,DistanciaPista,IdReuniao,NumPareo) VALUES('#{@pareo.nm_pareo}','#{@pareo.dt_pareo}','#{@pareo.tp_pista}',#{@pareo.distancia_pista},#{@pareo.id_reuniao},#{@pareo.num_pareo})")
  end

  def set_reuniao(id_hipodromo,dt_reuniao)
    rs = @con.query("select IdReuniao from Reuniao where IdHipodromo = #{id_hipodromo} and DtReuniao = '#{dt_reuniao}'")
    n_rows = rs.num_rows
    #puts "********** num_rows = " +  rs.num_rows.to_s

    if n_rows.eql?1
      rs.each_hash do |row|
        id_reuniao = row['IdReuniao']
        @pareo.id_reuniao= id_reuniao
      end
    end
  end

  def get_pareo_id()
    #puts "SELECT IdPareo FROM Pareo where DtPareo = '#{@pareo.dt_pareo}' and IdReuniao = #{@pareo.id_reuniao}"
    rs = @con.query("SELECT IdPareo FROM Pareo where DtPareo = '#{@pareo.dt_pareo}' and IdReuniao = #{@pareo.id_reuniao} and NumPareo = #{@pareo.num_pareo}")
    rs.each_hash do |row|
      return row['IdPareo']
    end
  end

end