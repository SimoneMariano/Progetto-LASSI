require 'nokogiri'
require 'httparty'

class BookScraperController < ApplicationController
    def index

        @isbn = params["ISBN"]
        @book_info_arr = []
        

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
                title: parsed_page.css('.master-page .boxproddetail h1')[0].text,
                img: parsed_page.css('#ctl00_ctl00_C_C_ProductDetail_zoom1')[0].attribute("href").value,
                author: author,
                author_link: author_link,
                prize: parsed_page.css('.master-page .boxproddetail .currentprice')[0].text,
                url: url,
                site: "Libraccio"
            }
            #byebug

            @book_info_arr[0] = @book_info

        end 


        def scraperLibreriaUniversitaria
            #pagina target
            url = 'https://www.libreriauniversitaria.it/ricerca/query/'+@isbn+'/'
            #html raw
            unparsed_page = HTTParty.get(url)
            #html codificato
            parsed_page = Nokogiri::HTML(unparsed_page)

            author_link = []
            author = []
            for i  in 0..parsed_page.css(".authors_and_publisher_url_html").size()-2 do
                #raccolgo gli author link
                author_link[i] = parsed_page.css(".authors_and_publisher_url_html")[i].attribute("href").value
                #raccolgo gli author
                author[i] = parsed_page.css(".authors_and_publisher_url_html")[i].text
            end
        
            @book_info = {
                title: parsed_page.css("a.product_title").text,
                img: parsed_page.css(".search-results-listing img.photo")[0].attribute("src").value,
                author: author,
                author_link: author_link,
                prize: parsed_page.css("div.product_our_price")[0].text,
                url: url,
                site: "Biblioteca Universitaria"
            
            }

            @book_info_arr[1] = @book_info
        end

        scraperLibraccio
        scraperLibreriaUniversitaria
        
    end

end
