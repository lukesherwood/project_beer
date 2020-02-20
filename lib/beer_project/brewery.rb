class BeerProject::Brewery
  @@all = []
  
  attr_accessor :name, :address, :website
  
  def initialize(attributes)
	attributes.each do |key, value|
		self.send("#{key.to_s}=", value)
  end
  end
  
  def self.all
    @@all
  end
  
  
end