module Tradesman
  module Configuration
    def configuration
      @configuration ||= Config.new
    end

    def reset
      @configuration = Config.new
      @adapter, @adapter_map = nil, nil # Class-level cache clear
    end

    def configure
      yield(configuration)
    end

    def adapter
      raise ::Tradesman::Errors::Base.new('Adapter has not been configured') unless configuration.adapter
      @adapter ||= configuration.adapter
    end
  end

  class Config
    attr_accessor :adapter, :namespaces

    def adapter=(adapter)
      Horza.configure { |config| config.adapter = adapter }
      @adapter = Horza.adapter
    end

    def development_mode=(mode)
      Horza.configure { |config| config.development_mode = mode }
    end

    def namespaces=(namespaces)
      fail Tradesman::Errors::Base.new 'namespaces must be an array' unless namespaces.is_a? Array
      Horza.configure { |config| config.namespaces = namespaces }
      @namespaces = namespaces
    end
  end
end
