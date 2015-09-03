module Dre
  class ApplicationController < ActionController::Base
    private

    def detect_platform
      if iphone?
        1
      elsif android?
        2
      end
    end

    def platform_header
      request.env['X-User-Platform']
    end

    def iphone?
      !!(platform_header.downcase =~ /iphone|ipad/)
    end

    def android?
      !!(platform_header.downcase =~ /android/)
    end
  end
end
