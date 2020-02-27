class BeerProject::Brewery
  @@all = []
  
  attr_accessor :name, :address, :website, :blurb, :phone_number, :city
  
  def initialize(name, address, city = BeerProject::City.name)
	  @name = name
	  @address = address
	  @city = city
		@@all << self
  end
  
  def self.all
    #needs to clear on loop
    BeerProject::Scraper.scrape_brewery_info if @@all.empty? 
    @@all
  end
  
  def self.clear
    @@all.clear
  end
  
  
end