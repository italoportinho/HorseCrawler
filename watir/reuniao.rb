# encoding: utf-8
class Reuniao
  attr_accessor :dt_reuniao, :num_reuniao, :id_hipodromo ,:nm_reuniao ,:mvto_geral_apostas

  def id_hipodromo=(nm_hipodromo)
     case nm_hipodromo
       when "GAVEA" then @id_hipodromo = 1
       when "CIDADE JARDIM" then @id_hipodromo = 2
       when "CRISTAL" then @id_hipodromo = 3
       when "TARUMA" then @id_hipodromo = 4
     end
  end
end