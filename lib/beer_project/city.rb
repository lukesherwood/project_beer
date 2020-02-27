class BeerProject::City
  attr_accessor :name, :website
  @@all = []
  def initialize(name, website)
    @name = name
    @website = website
    @@all << self
  end
  
  #does city need to know about its breweries?
  
  def self.all
    BeerProject::Scraper.scrape_cities if @@all.empty? 
    @@all.delete_if{|city| city.name == "Things To Do" || city.name =="Restaurants" || city.name =="Nightlife" || city.name =="Inspiration" || city.name =="Neighborhoods" || city.name =="Essentials" || city.name =="Events" || city.name =="Weird & Amazing" || city.name =="Getaways" || city.name == "Boston"}
    #can we move this to the scraper class - it ugly
  end
  
  
end