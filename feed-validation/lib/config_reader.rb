require 'yaml'

module Feed
  class ConfigReader
    CONFIG_PATH_DEFAULT='/etc/feed-validator/config.yaml'
    CONFIG_PATH_ENV_NAME = 'CONFIG_PATH'
    attr_reader :url
    attr_reader :xpath
    attr_reader :attributes
    attr_reader :keys
    attr_reader :query_param

    def initialize(environment, feed_type)
      file_path = ENV[CONFIG_PATH_ENV_NAME]|| File.absolute_path(CONFIG_PATH_DEFAULT)
      config = YAML.load_file(file_path)
      @url = config[environment]['host'][feed_type]
      @xpath = config['xpath'][feed_type+'-main']
      @attributes = config['xpath'][feed_type+'-attributes']
      @keys = config['jsonpath'][feed_type+'-keys']
      @query_param = config['param'][feed_type]
    end

  end
end