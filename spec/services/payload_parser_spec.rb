require 'rails_helper'

describe PayloadParser do
  let(:data) { 'eyJzdXBlcl9zZWNyZXRfbWVzc2FnZSI6ImRvbnRfcmVhZCJ9' }

  subject { described_class.new(data) }

  describe '#call' do
    it 'returns a hash' do
      expect(subject.call).to be_a_kind_of Hash
    end

    it 'returns decryped data' do
      result = { "super_secret_message" => "dont_read" }
      expect(subject.call).to eq result
    end
  end
end
