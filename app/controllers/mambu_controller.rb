class MambuController < ApplicationController
  def install
    send_file Rails.root.to_s + AppConfig.install_file_location
  end

  def safari
  end
end
