

class BeerProject::CLI
  
  def start
  puts "Lets find a brewery"
  Scraper.new("https://www.tripsavvy.com/best-breweries-in-cleveland-4688970")
  end
  
  
end