module Dre
  class ApplicationController < ActionController::Base
    class NilPlatform < RuntimeError ; end

    private

    def detect_platform
      if iphone?
        1
      elsif android?
        2
      end
    end

    def platform_header
      request.env['X-User-Platform'].tap do |header|
        raise Dre::NilPlatform unless header.present?
      end
    end

    def iphone?
      !!(platform_header.downcase =~ /iphone|ipad/)
    end

    def android?
      !!(platform_header.downcase =~ /android/)
    end
  end
end
