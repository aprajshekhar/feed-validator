require_relative 'feeds'
require_relative 'config_reader'
require 'pp'
require 'active_support'

module Feed
=begin
  SYNOPSIS
  Retrieves data from Solr and and parses it
=end
  class SolrFeed < Base
    FEED_TYPE = 'solr'

    def initialize(environment)
      config_reader = ConfigReader.new(environment, FEED_TYPE)
      url = config_reader.url
      @keys = config_reader.keys
      @query_param = config_reader.query_param
      super(url)
    end

    def parse
      parsed_names = []
      parsed_data = ActiveSupport::JSON.decode(retrieve.body)
      parsed_data['response']['docs'].each do |item|
        name =item['allTitle']
        # p name
        parsed_names << item['allTitle']
      end
      return parsed_names
    end

    private
    def retrieve
      params = Hash.new
      params['accept'] = 'application/vnd.redhat.solr+json'
      params['query'] = @query_param

      response = get_feed(params)

      if response.code != 200
        raise Exception('Could not retrieve solr feed')
      end
      # PP::pp response.body
      return response
    end
  end

end