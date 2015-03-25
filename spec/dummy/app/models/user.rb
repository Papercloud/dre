class User < ActiveRecord::Base
  acts_as_device_owner
end
