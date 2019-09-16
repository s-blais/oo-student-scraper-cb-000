require 'open-uri'
require 'pry'

class Scraper



  def self.scrape_index_page(index_url)
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      name = card.css(".student-name").text
      location = card.css(".student-location").text
      profile_url = card.css("a").attribute("href").value
      scraped_students << {name: name, location: location, profile_url: profile_url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_attributes = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |a|
      if a.attribute("href").value.include? ("twitter")
        scraped_attributes[:twitter] = a.attribute("href").value
      elsif a.attribute("href").value.include? ("linkedin")
        scraped_attributes[:linkedin] = a.attribute("href").value
      elsif a.attribute("href").value.include? ("github")
        scraped_attributes[:github] = a.attribute("href").value
      else scraped_attributes[:blog] = a.attribute("href").value
      end
      scraped_attributes[:profile_quote] = doc.css(".profile-quote").text
      scraped_attributes[:bio] = doc.css(".bio-block p").text
    end
    scraped_attributes
  end

end

#twitter, linkedin, github, blog, profilequote, bio
