class BeerProject::CLI
  
  def start
  puts "Lets find a brewery"
  BeerProject::Scraper.scrape_brewery_info
  end
  
  
end