require 'rails_helper'

describe PayloadAuthenticator do
  let(:key) { 'key' }
  let(:data) { 'c3VwZXJfc2VjcmV0X2RhdGE' }
  let(:hmac_signature) { '9968635b338a0c6deb63c9d1bba0ae4f62c168d87a168df611c858c1d32a04fe' }
  let(:second_hmac_signature) { 'd96825f86617a006525531d029baab5087f456d3953ec08d1921f7b229ccd340'}
  let(:signed_request) { "#{hmac_signature}.#{data}" }

  subject { described_class.new(signed_request) }

  describe '#coming_from_mambu?' do
    it 'returns true when signatures match' do
      expect(subject.coming_from_mambu?).to eq true
      expect(subject.data).to eq data
      expect(subject.received_signature).to eq hmac_signature
    end

    it 'returns false when signatures are different' do
      subject = described_class.new("#{second_hmac_signature}.#{data}")

      expect(subject.coming_from_mambu?).to eq false
      expect(subject.data).to eq data
      expect(subject.received_signature).to eq second_hmac_signature
    end
  end
end
