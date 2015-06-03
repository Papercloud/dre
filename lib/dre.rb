require 'dre/engine'
require 'dre/rails/routes'

require 'responders'

module Dre
  extend ActiveSupport::Autoload

  autoload :ActsAsDeviceOwner, 'dre/acts_as_device_owner'

  # Method to authenticate a user:
  mattr_accessor :authentication_method
  @@authentication_method = nil

  # Method to retrieve the current authenticated user:
  mattr_accessor :current_user_method
  @@current_user_method = nil

  private

  # Default way to setup Dre:
  def self.setup
    yield self
  end
end

module ActiveRecord
  class Base
    include Dre::ActsAsDeviceOwner
  end
end
