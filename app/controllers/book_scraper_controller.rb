require 'nokogiri'
require 'httparty'

class BookScraperController < ApplicationController
    def index

        @isbn = params["ISBN"]

        def scraperLibraccio
            #pagina target
            url = 'https://www.libraccio.it/libro/'+@isbn+'/'
            #html raw
            unparsed_page = HTTParty.get(url)
            #html codificato
            parsed_page = Nokogiri::HTML(unparsed_page)

            author_link = []
            author = []
            for i  in 0..parsed_page.css(".master-page .boxproddetail .author .dx").size()-1 do
                #raccolgo gli author link
                author_link[i] = "https://www.libraccio.it"+(parsed_page.css(".master-page .boxproddetail .author .dx")[i].attribute("href").value)
                #raccolgo gli author
                author[i] = parsed_page.css('.master-page .boxproddetail .author .dx')[i].text
            end

            @book_info = {
                title: parsed_page.css('.master-page .boxproddetail h1').text,
                img: parsed_page.css('#ctl00_ctl00_C_C_ProductDetail_zoom1').attribute("href").value,
                author: author,
                author_link: author_link,
                label_price: parsed_page.css('.master-page .boxproddetail .label-price').text,
                prize: parsed_page.css('.master-page .boxproddetail .currentprice').text,
                url: url
            }
            #byebug

            @book_info

        end 
        
        scraperLibraccio
        
    end

end
