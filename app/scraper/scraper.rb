require 'nokogiri'
require 'httparty'
#require 'byebug'

def scraperLibraccio
    #pagina target
    url = 'https://www.libraccio.it/libro/9788808420206/'
    #html raw
    unparsed_page = HTTParty.get(url)
    #html codificato
    parsed_page = Nokogiri::HTML(unparsed_page)

    book_info = {
        title: parsed_page.css('.master-page .boxproddetail h1').text,
        img: parsed_page.css('#ctl00_ctl00_C_C_ProductDetail_zoom1').attribute("href").value,
        author: (parsed_page.css('.master-page .boxproddetail .author').text).gsub("Autori:", " "),
        label_price: parsed_page.css('.master-page .boxproddetail .label-price').text,
        prize: parsed_page.css('.master-page .boxproddetail .currentprice').text,
        url: url
    }
    #byebug

    book_info
end




