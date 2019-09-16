require 'open-uri'
require 'pry'

class Scraper

  

  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      student = {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
      scraped_students << student
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

.student-card