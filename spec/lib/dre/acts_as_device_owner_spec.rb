require 'rails_helper'

describe 'a device owner class' do
  before :each do
    @owner = User.create
  end

  it 'responds to :acts_as_device_owner' do
    expect(@owner.class).to respond_to :acts_as_device_owner
  end

  describe 'instance' do
    before :each do
      @devices = create_list(:device, 3, owner: @owner)
    end

    it 'should have access to a collection of devices' do
      expect(@owner.devices).to match_array(@devices)
    end
  end
end
