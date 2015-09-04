require 'rails_helper'

module Dre
  RSpec.describe DevicesController, type: :controller do
    let(:user) { User.create }

    before :each do
      request.headers['X-User-Platform'] = 'iPhone'
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
        it 'returns a 201' do
          put :register, format: :json, token: 'Test Token'

          expect(response.status).to eq 201
        end

        it 'creates the device' do
          expect do
            put :register, format: :json, token: 'Test Token'
          end.to change(Device, :count).by(1)
        end

        it 'returns the new device' do
          put :register, format: :json, token: 'Test Token'

          expect(json['device']['id']).to_not be_nil
          expect(json['device']['token']).to eq 'Test Token'
        end

        it 'detects iphones as the ios platform' do
          request.headers['X-User-Platform'] = 'iPhone'

          put :register, format: :json, token: 'Test Token'
          expect(json['device']['platform']).to eq 'ios'
        end

        it 'detects ipads as the ios platform' do
          request.headers['X-User-Platform'] = 'iPad'

          put :register, format: :json, token: 'Test Token'
          expect(json['device']['platform']).to eq 'ios'
        end

        it 'detects androids as the android platform' do
          request.headers['X-User-Platform'] = 'Android'

          put :register, format: :json, token: 'Test Token'
          expect(json['device']['platform']).to eq 'android'
        end

        it 'raises an error if no platform is specified' do
          request.headers['X-User-Platform'] = nil

          expect do
            put :register, format: :json, token: 'Test Token'
          end.to raise_error
        end
      end

      context 'registering an existing device' do
        it "creates a new device if it's registered to another user" do
          @device = create(:device, owner: User.create, token: 'Test Token')

          put :register, format: :json, token: @device.token

          expect(json['device']['id']).to_not eq @device.id
          expect(json['device']['token']).to eq @device.token
        end

        it "returns the existing device if it's registered to the current user" do
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

        it 'deletes the device' do
          delete :deregister, format: :json, token: @device.token

          expect(response).to have_http_status(:success)
        end

        it 'returns 404 if trying to deregister a nonexistent device' do
          delete :deregister, format: :json, token: 'Some Other Token'

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
