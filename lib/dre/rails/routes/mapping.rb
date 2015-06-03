module Dre
  module Rails
    class Routes
      class Mapping
        attr_accessor :controllers, :as, :skips

        def initialize
          @controllers = {
            devices: 'dre/devices',
          }

          @as = {}
          @skips = []
        end

        def [](routes)
          {
            controllers: @controllers[routes],
            as: @as[routes]
          }
        end

        def skipped?(controller)
          @skips.include?(controller)
        end
      end
    end
  end
end
