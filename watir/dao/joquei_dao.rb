# encoding: utf-8
require_relative "../joquei"
require_relative "../database_test"
class JoqueiDAO
  attr_accessor :joquei,:existentes ,:existentes_id
  def initialize
    @joquei = Joquei.new
    @con = Mysql.new('localhost', 'root', '', 'horse_crawler')
    @existentes_id = {}
    @existentes = {}
    rs = @con.query("SELECT IdJoquei,NmJoquei FROM Joquei")
    rs.each_hash do |row|
      nome_joquei = row['NmJoquei']
      id_joquei = row['IdJoquei']
      @existentes[nome_joquei] = true
      @existentes_id[nome_joquei] = id_joquei
    end
  end

  def insert
    if !@existentes[@joquei.nm_joquei]
      puts "insert into Joquei(NmJoquei) values('#{@joquei.nm_joquei}')"
      @con.query("insert into Joquei(NmJoquei) values('#{@joquei.nm_joquei}')")
      rs = @con.query("SELECT IdJoquei FROM Joquei where NmJoquei = '#{@joquei.nm_joquei}'")
      rs.each_hash do |row|
        id_joquei = row['IdJoquei']
        @existentes_id[@joquei.nm_joquei] = id_joquei
      end
      @existentes[@joquei.nm_joquei] = true
      else puts "Joquei ja cadastrado."
    end

  end

  def get_joquei_id()
    @existentes_id[@joquei.nm_joquei]
  end

end