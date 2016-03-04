require 'rails_helper'

RSpec.describe Transaction do
  subject { create(:transaction) }

  describe '#modified_file_path' do
    it 'returns proper file path' do
      path = File.join(Rails.root, 'public', 'uploads',
       'transaction', 'excel_file', '1', 'modified_test.xls')

      expect(subject.modified_file_path).to eq path
    end
  end
end
