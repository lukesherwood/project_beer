class BeerProject::City
  attr_accessor :name, :website
  @@all = []
  def initialize(name, website)
    @name = name
    @website = website
    @@all << self
  end
  
  def self.all
    BeerProject::Scraper.scrape_cities if @@all.empty? 
    @@all.delete_if{|city| city.name == "Things To Do" || city.name =="Restaurants" || city.name =="Nightlife" || city.name =="Inspiration"}
  end
  
  
end