require 'dre/rails/routes/mapping'
require 'dre/rails/routes/mapper'

module Dre
  module Rails
    class Routes
      module Helper
        def mount_dre(options = {}, &block)
          Dre::Rails::Routes.new(self, &block).generate_routes!(options)
        end
      end

      def self.install!
        ActionDispatch::Routing::Mapper.send :include, Dre::Rails::Routes::Helper
      end

      attr_accessor :routes

      def initialize(routes, &block)
        @routes, @block = routes, block
      end

      def generate_routes!(options)
        @mapping = Mapper.new.map(&@block)
        routes.scope options[:scope] || '', as: 'dre' do
          map_route(:devices, :device_routes)
        end
      end

      private

      def map_route(name, method)
        unless @mapping.skipped?(name)
          send method, @mapping[name]
        end
      end

      def device_routes(mapping)
        routes.resources(
          :devices,
          controller: mapping[:controllers],
          as: :devices,
          path: 'devices',
          only: [:index],
        ) do |scope|
          routes.put    ':token', controller: mapping[:controllers], action: :register, on: :collection
          routes.delete ':token', controller: mapping[:controllers], action: :deregister, on: :collection
        end
      end
    end
  end
end
