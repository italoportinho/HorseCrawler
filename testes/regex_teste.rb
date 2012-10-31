# encoding: utf-8

require_relative "../watir/race_day"
class RegexTeste

  #  TESTE NOME DA MONTARIA E NOME DO JOQUEI
  stringao =  "LEGAL TIGRESS (466 kg)
Marcelle Martins (56 kg))"

  # nome damontaria
 # p stringao.to_s.gsub(/\((D|A|L|L1)\)/,"").gsub(/Est\./,"000").scan(/\A\D+\s*\(/)[0].gsub(/\s\(/,"").gsub(/'/,"")
  #p stringao.scan(/\A\D+\s*\(/)[0].class

  #nome do joquei
  p "nome do joquei: "
  p stringao.gsub(/\((D|A|A1|L|L1|L\-A|L1\-A|L1\-A1|P1|P2|URU|USA|IRE|ARG|PR|RJ|SP|RS)\)/,"").scan(/\)\D+\(|\)\D+\s/).first.gsub(/\)\s|\s\(|\)|\(/,"").gsub(/'/,"").gsub(/\s\Z/,"").gsub(/\A\s/,"")
  p "peso do joquei: "
  p stringao.to_s.scan(/\d+/).last
  p "nome da montaria: "
  p stringao.to_s.gsub(/\((D|A|A1|L|L1|L\-A|L1\-A|L1\-A1|P1|P2|URU|USA|IRE|ARG|PR|RJ|SP|RS)\)/,"").gsub(/\(Est\.|\(EST|\(EST\.|\(Est/,"(000").scan(/\A\D+\s\(/)[0].gsub(/\)\s|\s\(|\)|\(/,"").gsub(/'/,"").gsub(/\s\Z/,"").gsub(/\A\s/,"")
  p "peso da montaria :"
  p stringao.to_s.gsub(/\((D|A|A1|L|L1|L\-A|L1\-A|L1\-A1|P1|P2|URU|USA|IRE|ARG|PR|RJ|SP|RS)\)/,"").gsub(/\(Est\.|\(EST|\(EST\.|\(Est/,"(000").scan(/\d+/).first

  # TESTE IDADE DA IDADE E SEXO DA MONTARIA

=begin
  stringao  = "4 / Macho / Alázão"

  #p stringao.gsub!(/ã|á/,"a")

  p stringao.scan(/\d/)
=end

  # TESTE NOME DO HIPODROMO

=begin
  stringao = "REUNIÃO 77 GÁVEA GÁVEA RJ"
  p stringao.gsub(/Ã|Á/,"A").scan(/GAVEA|CRISTAL|CIDADE JARDIM|TARUMA/).first
  p stringao.scan(/\d+/).first
=end

=begin
  p Time.new.strftime("%d%m%Y")
  p RaceDay.new.next_date(Time.new.strftime("%d%m%Y"))
  #p  Date.strptime("05092012","%d%m%Y")
=end

=begin
  stringao = "Fêmea"
  puts stringao.gsub(/É|Ê/,"E").gsub(/é|ê/,"e").upcase
=end

end