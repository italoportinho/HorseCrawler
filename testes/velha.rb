class Velha
  frase = " "
  while(!frase.chomp.eql?"TCHAU")
    frase = readline
    if frase.chomp.gsub(/[A-Z]/,"").length.eql? 0 then
      puts "NAO, NAO DESDE 19#{rand(10..99)}!!!!"
    else puts  "O QUEE?? FALA MAIS ALTO!!!!!"
    end
  end
end