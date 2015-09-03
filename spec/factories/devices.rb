FactoryGirl.define do
  factory :device, class: 'Dre::Device' do
    sequence :token do |n|
      "Device Token #{n}"
    end

    owner_id 1
    owner_type 'User'
    platform :iphone
  end
end
