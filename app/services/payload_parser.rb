class PayloadParser
  attr_reader :data, :decrypted_data

  def initialize(data)
    @data = data
  end

  def call
    decrypt_data
    format_data
  end

  private

  def format_data
    decrypted_data.slice(1..-2).gsub(/"/, '').split(',').inject({}) do |hash, elem|
      key, value = elem.split(':')
      hash[key] = value
      hash
    end
  end

  def decrypt_data
    @decrypted_data = Base64.decode64(data)
  end
end
