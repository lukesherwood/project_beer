class BeerProject::CLI
  
  def start
  puts "What city are you in?"
  cities
  get_user_city
  breweries
  end
  
  def breweries
    puts "\nLets find a brewery!!!"
    puts "\nSelect a brewery you want to know more about by entering the number"
    BeerProject::Brewery.all.each.with_index(1) do |brewery, index|
      puts "\n#{index}. #{brewery.name}"
      puts brewery.address
      puts brewery.website
    end
  end
  
  def cities
    #need to add other pages of search
    @cities = BeerProject::City.all
    puts "Choose your city by entering the number"
  BeerProject::City.all.each.with_index(1) do |city, index|
      puts "#{index}. #{city.name}\n"
    end
  end
  
  def get_user_city
    chosen_city = gets.strip.to_i
    show_breweries_for(chosen_city) if valid_input(chosen_city, @cities)
  end
  
  def valid_input(input, data)
    input.to_i <= data.length && input.to_i > 0
  end
  
  def show_breweries_for(chosen_city)
    #need to get website from city class and put that through the scraper
  end
  
end