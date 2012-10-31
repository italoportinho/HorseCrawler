# encoding: utf-8
class Montaria
  attr_accessor  :nm_montaria, :tp_sexo, :idade

  # @param [String] nome
  def nm_montaria=(nome)
    @nm_montaria = nome.gsub(/Á|Ã|Â|À/,"A").gsub(/á|ã|â|à/,"a").gsub(/É|Ê/,"E").gsub(/é|ê/,"e").gsub(/Í/,"I").gsub(/í/,"i").gsub(/Õ|Ô|Ó/,"O").gsub(/õ|ô|ó/,"o").gsub(/Ü|Ú/,"U").gsub(/ü|ú/,"u").gsub(/Ç/,"C").gsub(/ç/,"c").upcase
  end

  def tp_sexo=(sexo)
    if sexo.nil?
      return "null"
      else @tp_sexo = "'" + sexo.gsub(/É|Ê/,"E").gsub(/é|ê/,"e").upcase + "'"
    end
  end

end