require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    #pagina target
    url = 'https://www.unilibro.it/libri/9788808420206'
    #html raw
    unparsed_page = HTTParty.get(url)
    #html codificato
    parsed_page = Nokogiri::HTML(unparsed_page)

    
        
        
    


    
    byebug

    
end

scraper



