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

    author_link = []
        author = []

        for i  in 0..parsed_page.css("li > span + a").size()-1 do
            #raccolgo gli author link
            author_link[i] = parsed_page.css("li > span + a")[i].attribute("href").value
            #raccolgo gli author
            author[i] = parsed_page.css("li > span + a")[i].text
        end

        @book_info = {
            title: parsed_page.css("h1.title").text,
            img: parsed_page.css("div.cover > img").attribute("src").value,
            author: author,
            author_link: author_link,
            prize: parsed_page.css("li.pVendita.droid > span").text,
            url: url,
            site: "Unilibro"
        },
        img: "https://www.mondadoristore.it/"+(parsed_page.css(".span2.spanfirst .product-image-max-heigth.new-image-gallery").attribute("src").value),
        author: author,
        author_link: author_link,
        prize: parsed_page.css("span.new-price").text,
        url: url,
        site: "Mondadori"
    


    
    byebug

    
end

scraper



