require 'rest_client'
require 'yaml'

module Feed
=begin
= SYNOPSIS
  Base class for all the feed readers/validators
=end
  class Base
    def initialize(url)
      @connection = RestClient::Resource.new(url)
    end

    def get_feed(params)

      if params.has_key?('query')
        return @connection['?q='+params['query'] ].get :accept=>params['accept']
      else
        return @connection.get :accept=>params['accept']
      end
    end

    def check_status
      return @connection.get().code
    end

  end

end
