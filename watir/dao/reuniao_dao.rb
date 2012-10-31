# encoding: utf-8
require_relative "../reuniao"
require_relative "../database_test"
class ReuniaoDAO
  attr_accessor :reuniao
  def initialize
    @reuniao = Reuniao.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
  end

  def insert
    @con.query("INSERT INTO REUNIAO(DtReuniao,IdHipodromo,NumReuniao,MvtoGeralApostas) VALUES ('#{@reuniao.dt_reuniao}',#{@reuniao.id_hipodromo},#{@reuniao.num_reuniao},'#{@reuniao.mvto_geral_apostas}')")
  end
end