# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  link       :string(255)
#  artist     :string(255)
#  event_date :string(255)
#  venue      :string(255)
#  location   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  name       :string(255)
#  tickets    :string(255)
#  support    :string(255)
#

class Event < ActiveRecord::Base
  belongs_to :user
  default_scope order('event_date DESC')
  require 'nokogiri'
  require 'open-uri'

  def parse(url)
    @url = url
    doc = Nokogiri::HTML(open(@url))
      if @url.include?('ticketmaster.com')
        tm(doc)
      elsif @url.include?('livenation.com')
        ln(doc)
      elsif @url.include?('ticketfly.com')
        tf(doc)
      elsif @url.include?('axs.com')
        axs(doc)
      elsif @url.include?('ticketweb.com')
        tw(doc)
      # elsif @url.include?('facebook.com')
      #   fb(doc)
      elsif @url.include?('eventbrite.com')
        eb(doc)
      elsif @url.include?('tickets.com')
        tcom(doc)
      elsif @url.include?('seatgeek.com')
        sg(doc)
      elsif @url.include?('stubhub.com')
        shub(doc)
      else
        msg = "Sorry, gigmarklet is unable to process that URL. Please make sure you submit the URL of an event page for one of the sites we currently support."
      end
    #  @auth.events << @event
    #  redirect_to @event
    # redirect_to root_path
  end

  def tm(doc) # ticketmaster scraper
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("div.artistDetails")[0].css("h1")[0].text
    self.venue = doc.css("span#artist_venue_name").children().text
    self.location = doc.css("span#artist_location").children().text
    self.event_date = doc.css("span#artist_event_date").children().text
    self.name = "#{self.artist} @ #{self.venue} #{self.event_date}"
    self.save
  end

  def ln(doc) # livenation.com scraper -- needs title, support
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("h1.headliner").text
    self.event_date = (doc.css("div.date").css("div.month").text) + (doc.css("div.date").css("div.day").text) + (doc.css("div.date").css("div.year").text) + (doc.css("div.date").css("div.time").text)
    self.venue = doc.css("div.venue").css("div.name").text
    self.location = doc.css("div.venue").css("div.location").text
    self.name = "#{self.artist} @ #{self.venue}, #{self.event_date}"
    self.save
    # @event = Event.create(:link => link, :artist => artist, :venue => venue, :location => location, :event_date => event_date)
    # @auth.events << @event
  end

  def tf(doc) # ticketfly scraper
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("h1.headliners").text
    self.support = doc.css("div.event-titles").css("h3").text
    self.event_date = (doc.css("div.event-date").css("p.event-date-day-of-week").text) + (doc.css("div.event-date").css("p.event-date-month").text) + (doc.css("div.event-date").css("p.event-date-day").text)
    self.venue = doc.css("div.event-venue.location.vcard").css("h5.venue.fn.org").text.squish
    self.location = doc.css("div.event-venue.location.vcard").css("p.city-state.adr").text
    self.name = "#{self.artist} @ #{self.venue}, #{self.event_date}"
    self.save
  end

  def axs(doc) # axs scraper
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("h1.edp_headliner").text
    self.support = doc.css("div.edp_support").text.squish
    self.event_date = doc.css("div.edp_showtime").text
    self.venue = doc.css("div.edp_venue_name").text
    self.location = doc.css("div.edp_venue_address").text
    self.name = "#{self.artist} @ #{self.venue}, #{self.event_date}"
    self.save
  end

  def tw(doc) # ticketweb scraper
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("div.artist-text").css("h1.highlight").text
    # self.support
    self.event_date = doc.css("div.artist-text").css("p").children()[1].text
    self.venue = doc.css("div.artist-text").css("span.text-addons").text
    self.location = doc.css("div.artist-text").css("span[itemprop=location]").css("span[itemprop=address]").text
    self.name = "#{self.artist} @ #{self.venue}, #{self.event_date}"
    self.save
  end

  def tcom(doc)
  end

  def sg(doc)
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("div.event-infobar").css("div.event-description").css("strong").text
    # self.support is included in artist/name
    self.event_date = doc.css("div.event-infobar").css("div.event-date").text.squish
    self.venue = doc.css("div.event-infobar").css("div.event-venue").text.squish
    # self.location is included in venue above
    self.name = "#{self.artist} @ #{self.venue}, #{self.event_date}"
    self.save
  end

  def shub(doc)
  end

  def eb(doc)
    self.link = @url
    self.tickets = @url
    self.artist = doc.css("div#event_header").css('span.summary').text
    self.venue = doc.css("h2.location.vcard").text.squish
    # self.location = nil
    # self.support =
    # self.event_date =
    # self.name = "#{self.artist} @ #{self.venue}, #{self.event_date}"
    binding.pry
  end

end
