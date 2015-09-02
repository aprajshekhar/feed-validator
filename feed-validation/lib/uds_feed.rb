require_relative 'config_reader'
require_relative 'feeds'
require 'nokogiri'

module Feed
=begin
  SYNOPSIS
  Retrieves data from UDS and and parses it
=end
  class UdsFeed < Base
    FEED_TYPE='uds'
    def initialize(environment)
      config_reader = ConfigReader.new(environment,FEED_TYPE)
      url = config_reader.url
      @xpath = config_reader.xpath
      @attributes = config_reader.attributes.split(',')
      super(url+'/search')

    end

    def parse
      parsed_names = []
      doc = Nokogiri::XML(retrieve.body)

      doc.xpath(@xpath).each do |item|
        if item.attr(@attributes[0])== 'portal_name'
          parsed_names << item.attr(@attributes[1])
        end
      end

      return parsed_names

    end

    private
    def retrieve
      params = Hash.new
      params['accept'] = 'application/xml'
      response = get_feed(params)
      if response.code != 200
        raise Exception('Could not retrieve feed')
      end
      # PP.pp response.body
      return response


    end
  end
end