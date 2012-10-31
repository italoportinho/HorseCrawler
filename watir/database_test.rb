require 'mysql'
require 'date'
require_relative "race_day"

class DatabaseTest
#my = Mysql.new(hostname, username, password, databasename)
  attr_accessor :con

  def initialize
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
  end

  #rs = @con.query('select * from Hipodromo')
  #rs.each_hash { |h| puts h['NmHipodromo'].to_s.force_encoding("UTF-8") + "\n"}
  #@con.close

  def show
    rs = @con.query('select * from Hipodromo')
    rs.each_hash { |h| puts h['NmHipodromo'].to_s.force_encoding("UTF-8") + "\n"}
  end

end