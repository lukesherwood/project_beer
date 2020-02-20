class BeerProject::Brewery
  @@all = []
  
  attr_accessor :name, :address, :website
  
  def self.all
    @@all
  end
  
  
end