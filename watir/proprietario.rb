# encoding: utf-8
class Proprietario
  attr_accessor :nm_proprietario

  def nm_proprietario=(nome)
    @nm_proprietario = nome.gsub(/Á|Ã|Â|À/,"A").gsub(/á|ã|â|à/,"a").gsub(/É|Ê/,"E").gsub(/é|ê/,"e").gsub(/Í/,"I").gsub(/í/,"i").gsub(/Õ|Ô|Ó/,"O").gsub(/õ|ô|ó/,"o").gsub(/Ü|Ú/,"U").gsub(/ü|ú/,"u").gsub(/Ç/,"C").gsub(/ç/,"c").upcase
  end

end