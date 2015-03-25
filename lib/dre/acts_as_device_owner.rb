module Dre
  module ActsAsDeviceOwner
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_device_owner(_options = {})
        has_many :devices, as: :owner, class_name: 'Dre::Device'
      end
    end
  end
end
