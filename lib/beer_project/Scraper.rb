class BeerProject::Scraper
  
  def self.site=(site)
    @site = site
  end
  
  def self.scrape_brewery_info
  begin
  doc = Nokogiri::HTML(open(@site))
  things = doc.css(".comp.list-sc-item.mntl-block")
  rescue
  puts "\nThat is not valid\n"
  sleep(2)
  BeerProject::CLI.new.start
  end
  things.each do |thing|
      name =        thing.css(".mntl-sc-block-heading__text").text
      name =        thing.css(".mntl-sc-block-heading__link").text if name == "" #covers case if name is a link
      website =     thing.css(".mntl-sc-block-location__website-text").attr("href") 
      website =     thing.css(".mntl-sc-block-heading__link").attr("href") if website == nil #covers edge case when no website, but website in name link
      address =     thing.css(".mntl-sc-block-location__address").text.strip
      blurb =       thing.css(".comp.text-passage").text
      phone_number= thing.css(".mntl-sc-block-location__phone-text").text
      
    brewery = BeerProject::Brewery.new(name, address)
    brewery.website = website
    brewery.blurb = blurb
    brewery.phone_number = phone_number
    end
  end
  
  def self.scrape_cities
    self.scrape_cities_page1
    self.scrape_cities_page2
  end
  
  def self.scrape_cities_page1
    @pages = ["https://www.tripsavvy.com/search?q=best%20breweries", "https://www.tripsavvy.com/search?q=best%20breweries&offset=24", "https://www.tripsavvy.com/search?q=best%20breweries&offset=48"]
    
    doc = Nokogiri::HTML(open(@pages[0]))

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
  
  def self.scrape_cities_page2
    @pages = ["https://www.tripsavvy.com/search?q=best%20breweries", "https://www.tripsavvy.com/search?q=best%20breweries&offset=24", "https://www.tripsavvy.com/search?q=best%20breweries&offset=48"]
    
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