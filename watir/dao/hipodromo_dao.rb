require_relative "../hipodromo"
require_relative "../database_test"

class HipodromoDAO < DatabaseTest
  attr_accessor :hipodromo
  def initialize
    @hipodromo = Hipodromo.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
  end

  def insert
    @con.query("INSERT INTO HIPODROMO(NmHipodromo) VALUES ('#{@hipodromo.nm_hipodromo}')")
  end

end