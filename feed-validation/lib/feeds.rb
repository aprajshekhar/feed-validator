require 'rest_client'
require 'yaml'

module Feed
=begin
= SYNOPSIS
  Base class for all the feed readers/validators
=end
  class Base
    def initialize(url, ssl=false)
      if ssl
        @connection = RestClient::Resource.new(url, :verify_ssl => OpenSSL::SSL::VERIFY_NONE)
      else
        @connection = RestClient::Resource.new(url)
      end

    end

    def get_feed(params)

      sub_url = params['sub-url'] if params.has_key?('sub-url')

      if params.has_key?('query')
        return @connection[sub_url+'?q='+params['query'] ].get :accept=>params['accept']
      else
        return @connection.get :accept=>params['accept']
      end
    end

    def check_status
        begin
            return @connection.get().code
        rescue => e
            p 'error response received: ['+e.response+']'
            return e.response.code
        end
    end

  end

end
