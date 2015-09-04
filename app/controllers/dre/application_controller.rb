module Dre
  class ApplicationController < ActionController::Base
    class Dre::NilPlatform < RuntimeError ; end

    private

    def detect_platform
      if ios?
        :ios
      elsif android?
        :android
      end
    end

    def platform_header
      request.headers['X-User-Platform'].tap do |header|
        raise Dre::NilPlatform unless header.present?
      end
    end

    def ios?
      !!(platform_header.downcase =~ /iphone|ipad/)
    end

    def android?
      !!(platform_header.downcase =~ /android/)
    end
  end
end
