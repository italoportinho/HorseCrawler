require 'rubygems'
require 'mechanize'
require 'logger'

class Testes

  attr_accessor :raw_page, :url

  agent = Mechanize.new
  agent.user_agent_alias = 'Windows Mozilla'

  agent.log = Logger.new "mech.log"

  @url = "http://www.jcb.com.br/conteudo/Reuniao?dia=05012012&idReuniao=0"

  @raw_page = agent.get(@url)



  @raw_page.links_with(:id => /3/).each do |link|
    puts link.click
  end

  #puts @raw_page.parser.xpath('//*[@id="MainContent_gvAnimaisFechado"]')


end