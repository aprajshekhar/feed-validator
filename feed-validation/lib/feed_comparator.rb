# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'uds_feed'
require_relative 'solr_feed'
require 'facets'

class FeedComparator


  def initialize(environment)
    @uds_feed = Feed::UdsFeed.new(environment)
    @solr_feed = Feed::SolrFeed.new(environment)
    @solr_names = []
    @uds_names = []
  end

  def check_status(feed_type)
    return @uds_feed.check_status if feed_type == 'uds'
    return @solr_feed.check_status if feed_type == 'solr'
  end

  def retrieve_uds_feed_names
    @uds_names = @uds_feed.parse
  end

  def retrieve_solr_feed_names
    @solr_names = @solr_feed.parse
  end

  def compare_feeds
    return @uds_names.frequency == @solr_names.frequency
  end

  def description_exists_solr?
    return @solr_feed.parsed_details.all? do |k, v|
      !v.nil?
    end
  end
end