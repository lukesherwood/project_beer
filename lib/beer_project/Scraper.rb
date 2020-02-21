class BeerProject::Scraper
  #attr_accessor :site
  

#site = "https://www.tripsavvy.com/best-breweries-in-cleveland-4688970"
  def self.scrape_brewery_info
  doc = Nokogiri::HTML(open("https://www.tripsavvy.com/best-breweries-in-cleveland-4688970"))
  things = doc.css(".comp.list-sc-item.mntl-block")
  
  things.each do |thing|
    name = thing.css(".mntl-sc-block-heading__text").text
    website = thing.css(".mntl-sc-block-location__website-text").attr("href")
    address = thing.css(".mntl-sc-block-location__address").text.strip
    BeerProject::Brewery.new(name, address, website)
    end
  end
  
  def self.scrape_cities
    doc = Nokogiri::HTML(open("https://www.tripsavvy.com/search?q=best%20breweries"))

    things = doc.css(".comp.l-container.search-results-list li")
    things.each do |thing|
      name = thing.css(".card__tag").attr("data-tag").text
      website = thing.css(".comp.card").attr("href").text
      BeerProject::City.new(name, website)
    end
  end
 
end