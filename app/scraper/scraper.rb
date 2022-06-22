require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    #pagina target
    url = 'https://www.amazon.it/s?k=9788808420206&crid=3DEM48XS6UPSJ&sprefix=%2Caps%2C167&ref=nb_sb_ss_recent_1_0_recent'
    #html raw
    unparsed_page = HTTParty.get(url)
    #html codificato
    parsed_page = Nokogiri::HTML(unparsed_page)

    author_link = []
    author = []
    


    
    byebug

    
end

scraper



