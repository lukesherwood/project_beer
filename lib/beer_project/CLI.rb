class BeerProject::CLI
  
  def start
  puts "Lets find a brewery"
  Scraper.new()
  end
  
  
end