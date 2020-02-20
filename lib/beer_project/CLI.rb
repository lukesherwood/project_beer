

class BeerProject::CLI
  
  def start
  puts "Lets find a brewery"
  BeerProject::Scraper.new.get_page
  end
  
  
end