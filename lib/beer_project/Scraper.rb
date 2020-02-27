class BeerProject::Scraper
  
  def self.site=(site)
    @site = site
  end
  
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
      
      brewery = BeerProject::Brewery.new(name)
      brewery.address = address
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
    
    #need to condense this with page2
    @pages = ["https://www.tripsavvy.com/search?q=best%20breweries", "https://www.tripsavvy.com/search?q=best%20breweries&offset=24"]
    
    doc = Nokogiri::HTML(open(@pages[0]))

    things = doc.css(".comp.l-container.search-results-list li")
    things.each do |thing|
      name = thing.css(".card__tag").attr("data-tag").text
      website = thing.css(".comp.card").attr("href").text
      
      not_cities = ["Things To Do", "Restaurants", "Nightlife", "Inspiration", "Neighborhoods", "Essentials", "Events", "Weird & Amazing", "Getaways", "Boston"]
      BeerProject::City.new(name, website) unless not_cities.include? name
      
    end
  end
  
  def self.scrape_cities_page2
    @pages = ["https://www.tripsavvy.com/search?q=best%20breweries", "https://www.tripsavvy.com/search?q=best%20breweries&offset=24"]
    
    doc = Nokogiri::HTML(open(@pages[1]))

    things = doc.css(".comp.l-container.search-results-list li")
    things.each do |thing|
      begin
      name = thing.css(".card__tag").attr("data-tag").text
      website = thing.css(".comp.card").attr("href").text
      rescue NoMethodError #this stops the error when cities don't have all the info
        next
      else
      not_cities = ["Things To Do", "Restaurants", "Nightlife", "Inspiration", "Neighborhoods", "Essentials", "Events", "Weird & Amazing", "Getaways", "Boston"]
      BeerProject::City.new(name, website) unless not_cities.include? name
      end
    end
  end
 
end