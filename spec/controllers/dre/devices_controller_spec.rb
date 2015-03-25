require 'rails_helper'

module Dre
  RSpec.describe DevicesController, type: :controller do
    routes { Dre::Engine.routes }

    let(:user) { User.create }

    before :each do
      allow(controller).to receive(:authenticate!) { true }
      allow(controller).to receive(:user) { user }
    end

    describe 'GET #index' do
      before :each do
        @device = create(:device, owner: user)
      end

      it 'returns http success' do
        get :index, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'should assign a collection of devices for the current user' do
        get :index, format: :json
        expect(assigns(:devices)).to match_array([@device])
      end
    end

    describe 'PUT #register' do
      context 'registering a new device' do
        it 'should return a 201' do
          put :register, format: :json, token: 'Test Token'

          expect(response.status).to eq 201
        end

        it 'should create the device' do
          expect do
            put :register, format: :json, token: 'Test Token'
          end.to change(Device, :count).by(1)
        end

        it 'should return the new device' do
          put :register, format: :json, token: 'Test Token'

          expect(json['device']['id']).to_not be_nil
          expect(json['device']['token']).to eq 'Test Token'
        end
      end

      context 'registering an existing device' do
        it "should create a new device if it's registered to another user" do
          @device = create(:device, owner: User.create, token: 'Test Token')

          put :register, format: :json, token: @device.token

          expect(json['device']['id']).to_not eq @device.id
          expect(json['device']['token']).to eq @device.token
        end

        it "should return the existing device if it's registered to the current user" do
          @device = create(:device, owner: user, token: 'Test Token')

          put :register, format: :json, token: @device.token

          expect(json['device']['id']).to eq @device.id
          expect(json['device']['token']).to eq @device.token
        end
      end

      describe 'DELETE #deregister' do
        before :each do
          @device = create(:device, owner: user)
        end

        it 'should delete the device' do
          delete :deregister, format: :json, token: @device.token

          expect(response).to have_http_status(:success)
        end

        it 'should return 404 if trying to deregister a nonexistent device' do
          delete :deregister, format: :json, token: 'Some Other Token'

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
