class BeerProject::CLI
  
  def start
  puts "Lets find a brewery"
  breweries
  end
  
  def breweries
    BeerProject::Brewery.all.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address
      puts brewery.website
    end
  end
  
  
end