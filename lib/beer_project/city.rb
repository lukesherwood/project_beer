class BeerProject::City
  attr_accessor :name, :website
  @@all = []
  def initialize(name, website)
    @name = name
    @website = website
    @@all << self
  end
  
  def self.name
    @@name = @name
  end
  
  def breweries
    BeerProject::Brewery.all
  end
  
  def self.all
    BeerProject::Scraper.scrape_cities if @@all.empty? 
    @@all
  end
  
end