require 'rails_helper'

module Dre
  RSpec.describe Device, type: :model do
    describe 'associations' do
      it 'belongs to an owner' do
        @user = User.create
        @device = create(:device, owner: @user)

        expect(@user.devices).to include(@device)
      end
    end

    describe 'validations' do
      before :each do
        @device = build(:device)
      end

      it 'cannot be created without a token' do
        @device.token = nil

        expect(@device).to_not be_valid
      end

      it 'cannot be created without a owner' do
        @device.owner = nil

        expect(@device).to_not be_valid
      end
    end

    describe 'hooks' do
      before :each do
        @device = build(:device, token: '12345', owner_id: 1)
      end

      describe '.invalidate_used_token' do
        it 'should delete any existing registratios with the saved token' do
          @old_device = create(:device, token: '12345', owner_id: 2)

          expect do
            @device.save
            Device.find(@old_device.id)
          end.to raise_error(ActiveRecord::RecordNotFound)

          expect do
            Device.find(@device.id)
          end.to_not raise_error
        end
      end
    end
  end
end
