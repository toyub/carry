module Erp
  class BaseController < ApplicationController
    # before_filter :auth_token, :authenticate_user

    respond_to :json

    private

    def default_serializer_options
      {root: false}
    end

    def auth_token
      return if Rails.env == 'development'
      render json: {errors: ["app token incrrect"]}, status: 401 and return unless AuthenticateTokenService.authenticate!(request.headers["X-Client-Key"])
    end

    def current_user
      @current_user ||= StoreStaff.find_by(login_name: request.headers["X-Username"])
    end

    def authenticate_user
      render json: {errors: ["not logined"]}, status: 402 and return unless current_user.present?
    end

    def current_store_chain
      # current_user.store_chain
      StoreChain.find(2400)
    end
  end
end
