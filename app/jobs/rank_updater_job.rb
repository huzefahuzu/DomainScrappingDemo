class RankUpdaterJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    require 'nokogiri'
    require 'open-uri'
    Domain.find_each do |d|
      doc = Nokogiri::HTML(open("http://www.alexa.com/siteinfo/#{d.url}"))

      # To Do For Future Purpose
      # doc.css('span.countryRank strong.metrics-data').each do |d|
      #   @country_rank = d.content
      # end
      # @country_rank.gsub(',','').to_i

      # To Do Take it as last value without looping
      doc.css('span.globleRank strong.metrics-data').each do |d|
        @global_rank = d.content
      end
      d.domain_ranks.create(rank: @global_rank.gsub(',','').to_i, rank_time: DateTime.now)
    end
  end
end
