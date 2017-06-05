require_dependency 'dre/application_controller'

module Dre
  class DevicesController < ApplicationController
    before_action :authenticate!

    respond_to :json

    def index
      render json: { devices: collection }
    end

    def register
      @device = collection.where(token: params[:token]).first || Device.new(owner: user, token: params[:token])
      @device.platform = detect_platform

      response = @device.persisted? ? 200 : 201

      if @device.save
        render json: { device: @device }, root: false, status: response
      else
        render json: { errors: @device.errors }, status: :unprocessable_entity
      end
    end

    def deregister
      @device = collection.where(token: params[:token]).first

      if @device.nil?
        render nothing: true, status: :not_found
      elsif @device.destroy
        render nothing: true, status: :ok
      else
        render json: { errors: @device.errors }, status: :unprocessable_entity
      end
    end

    private

    def authenticate!
      method(Dre.authentication_method).call
    end

    def user
      @user ||= method(Dre.current_user_method).call
    end

    def collection
      @devices ||= Device.for_owner(user).limit(30)
    end
  end
end
