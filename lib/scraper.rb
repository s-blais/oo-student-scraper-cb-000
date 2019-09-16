require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      name = card.css(".student-name").text
      location = card.css(".student-location").text
      profile_url = card.css("a").attribute("href").value
      students_array << {name: name, location: location, profile_url: profile_url}
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    attributes = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |a|
      if a.attribute("href").value.include? ("twitter")
        attributes[:twitter] = a.attribute("href").value
      elsif a.attribute("href").value.include? ("linkedin")
        attributes[:linkedin] = a.attribute("href").value
      elsif a.attribute("href").value.include? ("github")
        attributes[:github] = a.attribute("href").value
      else attributes[:blog] = a.attribute("href").value
      end
      attributes[:profile_quote] = doc.css(".profile-quote").text
      attributes[:bio] = doc.css(".bio-block p").text
    end
    attributes
  end

end
