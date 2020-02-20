
class Scraper
  def initialize(site)
    @site = site
  end

#site = "https://www.tripsavvy.com/best-breweries-in-cleveland-4688970"

doc = Nokogiri::HTML(open(@site))


things = doc.css(".comp.list-sc-item.mntl-block")

#puts things.count

things.each do |thing|
name = thing.css(".mntl-sc-block-heading__text").text
   website = thing.css(".mntl-sc-block-location__website-text").attr("href")
  address = thing.css(".mntl-sc-block-location__address").text.strip
   # For testing purposes we can print it straight to our console
   # But in our real app we'll want to make a new object with the data eg:
   # Thing.new(detainamel_one, detail_two, detail_three)
   puts name, website, address, ""
 end
 
 end