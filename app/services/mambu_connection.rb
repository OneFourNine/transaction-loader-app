class MambuConnection
  attr_reader :credentials

  def initialize(credentials)
    @credentials = credentials
  end

  def established?
    setup_connection
  end

  private

  def setup_connection
    connection = Mambu::Connection.new(credentials[:user_name],
                                       credentials[:password],
                                       tenant)
  rescue Mambu::Error
    false
  else
    connection
  end

  def tenant
    if Rails.env.production?
      credentials[:tenant]
    else
      "#{credentials[:tenant]}.sandbox"
    end
  end

end
