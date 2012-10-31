class RaceDay

  attr_accessor :data_atual ,:datas , :index_ultima_data

  def initialize
    date = Time.new
    @datas = []
    @index_ultima_data = -1
    teste_dia = date.wday

    # 0:domingo ; 1:segunda; 2:terça; 3:quarta; 4:quinta; 5:sexta; 6:sabado

    @data_atual = date.strftime("%d%m%Y")
    @datas << @data_atual
    @index_ultima_data = @index_ultima_data + 1

  end

  def next_date()
    # Converto a data de entrada que vem como string para Date, com a finalidade de poder subtrair dias da data.
    date = Date.strptime(@datas[@datas.length - 1],"%d%m%Y")

    if date.thursday?
      # Se for quinta , subtrai-se tres dias.
      date = date.to_time - 86400*3

      # A data retorna em formato de string
      @datas << date.strftime("%d%m%Y")
      @index_ultima_data = @index_ultima_data + 1
      return @datas[@datas.length - 1]
    end

    if date.wednesday?
      # Se for quarta , subtrai-se dois dias.
      date = date.to_time - 86400*2

      # A data retorna em formato de string
      @datas << date.strftime("%d%m%Y")
      @index_ultima_data = @index_ultima_data + 1
      return @datas[@datas.length - 1]
    end

    # No caso geral, subtrai-se um dia e obtem-se a proxima data valida.
    date = date.to_time - 86400
    @datas << date.strftime("%d%m%Y")
    @index_ultima_data = @index_ultima_data + 1
    return @datas[@datas.length - 1]

  end

end