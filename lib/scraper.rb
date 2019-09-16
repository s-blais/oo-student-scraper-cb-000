require 'open-uri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    #binding.pry
    doc.css(".student-card").each do |card|
      name = card.css(".student-name").text
      location = card.css(".student-location").text
      profile_url = card.css("a").attribute("href").value
      scraped_students << {name: name, location: location, profile_url: profile_url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
