class Moderation::BaseController < ApplicationController
  before_action :http_authenticate

  private

  def http_authenticate
    return unless Rails.env.production?

    secret_username = Rails.application.credentials.dig(:http_auth, :username)
    secret_password = Rails.application.credentials.dig(:http_auth, :password)

    authenticate_or_request_with_http_basic do |username, password|
      username == secret_username && password == secret_password
    end
  end
end
