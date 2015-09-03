require 'rails_helper'

module Dre
  RSpec.describe Device, type: :model do
    describe 'associations' do
      it { should belong_to(:owner) }
    end

    describe 'validations' do
      it { should validate_presence_of(:platform) }
      it { should validate_presence_of(:token) }
      it { should validate_presence_of(:owner_id) }
      it { should validate_presence_of(:owner_type) }
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
