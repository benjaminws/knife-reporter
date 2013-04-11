class Chef
  class Knife
    module ReporterBase
      def self.included(includer)
        includer.class_eval do
          deps do
            require 'chef/node'
            require 'chef/environment'
            require 'chef/api_client'
            require 'chef/search/query'
          end
        end
      end
    end
  end
end
