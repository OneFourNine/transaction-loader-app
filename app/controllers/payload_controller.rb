class PayloadController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :main

  def main
    authenticator = PayloadAuthenticator.new(signed_request)

    if authenticator.coming_from_mambu?
      data = PayloadParser.new(authenticator.data).call
      save_data_in_session(data)
      Tenant.find_or_create_by(name: data['TENANT_ID'])
      redirect_to transactions_path
    else
      Rails.logger.error "Generated hash didn't match payload data"
      render status: 422
    end
  end

  protected

  def save_data_in_session(data)
    data.each do |key, value|
      session[key] = value
    end

    session[:user_key] ||= SecureRandom.uuid
  end

  def signed_request
    params[:signed_request]
  end
end
