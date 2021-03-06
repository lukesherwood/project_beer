class BeerProject::Scraper
  
  def self.site=(site)
    @site = site
  end
  
  def self.scrape_brewery_info
    doc = Nokogiri::HTML(open(@site))

    cards = doc.css(".comp.list-sc-item.mntl-block")
    cards.each do |attributes|
      name =        attributes.css(".mntl-sc-block-heading__text").text
      name =        attributes.css(".mntl-sc-block-heading__link").text if name == "" #covers case if name is a link
      website =     attributes.css(".mntl-sc-block-location__website-text").attr("href") 
      website =     attributes.css(".mntl-sc-block-heading__link").attr("href") if website == nil #covers case when no website, but website in name link
      address =     attributes.css(".mntl-sc-block-location__address").text.strip
      blurb =       attributes.css(".comp.text-passage").text
      phone_number= attributes.css(".mntl-sc-block-location__phone-text").text
      
      brewery = BeerProject::Brewery.new(name)
      brewery.address = address
      brewery.website = website
      brewery.blurb = blurb
      brewery.phone_number = phone_number
    end
  end
  
  def self.scrape_cities
    @pages = ["https://www.tripsavvy.com/search?q=best%20breweries", "https://www.tripsavvy.com/search?q=best%20breweries&offset=24"]
    
    doc = [Nokogiri::HTML(open(@pages[0])), Nokogiri::HTML(open(@pages[1]))]
    
    doc.each do |pages| 
      cards = pages.css(".comp.l-container.search-results-list li")

        cards.each do |attributes|
          begin
            name = attributes.css(".card__tag").attr("data-tag").text
            website = attributes.css(".comp.card").attr("href").text
            rescue NoMethodError #skips to when cities don't have all the info
              next
            else
              not_cities = ["Things To Do", "Restaurants", "Nightlife", "Inspiration", "Neighborhoods", "Essentials", "Events", "Weird & Amazing", "Getaways", "Boston"]
              BeerProject::City.new(name, website) unless not_cities.include? name
          end
        end
    end
  end
  
end