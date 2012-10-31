#require 'rubygems'
#require 'bundler/setup'
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'

class TesteCapybara
  Capybara.run_server = false
  Capybara.current_driver = :webkit
  Capybara.default_selector = :xpath
  Capybara.app_host = 'http://www.jcb.com.br/conteudo/Reuniao?dia=03092012&idReuniao=0'

  module MyCapybaraTest
    class Test
      include Capybara::DSL
      def test_horse
        visit('/')
        #find('/html/body/div[2]/form/div[4]/div/div[2]/div[3]/div/div/div[2]/ul/li/a/span').text
      end
    end
  end

 # puts Capybara.find('/html/body/div[2]/form/div[4]/div/div[2]/div[3]/div/div/div[2]/ul/li/a/span').text

  t = MyCapybaraTest::Test.new
  t.test_horse

end