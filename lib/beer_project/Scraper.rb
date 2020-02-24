class BeerProject::Scraper
  
  def self.site=(site)
    ##not working
    @site = site
  end
  
  #"https://www.tripsavvy.com/best-breweries-in-cleveland-4688970"
  def self.scrape_brewery_info
  doc = Nokogiri::HTML(open(@site))
  things = doc.css(".comp.list-sc-item.mntl-block")
  
  things.each do |thing|
      name =        thing.css(".mntl-sc-block-heading__text").text
      name =        thing.css(".mntl-sc-block-heading__link").text if name == "" #covers case if name is a link
      website =     thing.css(".mntl-sc-block-location__website-text").attr("href") 
      website =     thing.css(".mntl-sc-block-heading__link").attr("href") if website == nil #covers edge case when no website, but website in name link
      address =     thing.css(".mntl-sc-block-location__address").text.strip
      blurb =       thing.css(".comp.text-passage").text
      phone_number= thing.css(".mntl-sc-block-location__phone-text").text
      
    BeerProject::Brewery.new(name, address, website, blurb, phone_number)
    end
  end
  
  def self.scrape_cities
    @pages = ["https://www.tripsavvy.com/search?q=best%20breweries", "https://www.tripsavvy.com/search?q=best%20breweries&offset=24", "https://www.tripsavvy.com/search?q=best%20breweries&offset=48]"]
    doc = Nokogiri::HTML(open(@pages[1]))

    things = doc.css(".comp.l-container.search-results-list li")
    things.each do |thing|
      begin
      name = thing.css(".card__tag").attr("data-tag").text
      website = thing.css(".comp.card").attr("href").text
      rescue NoMethodError
        next
      #need to add a error that misses cities without all information
      else
      BeerProject::City.new(name, website)
      end
    end
  end
 
end