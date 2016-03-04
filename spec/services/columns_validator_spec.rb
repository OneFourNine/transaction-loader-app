require 'rails_helper'

describe ColumnsValidator do
  let(:file_columns) { FileTransaction::COLUMN_NAMES }

  describe '#valid?' do
    it 'returns true when all required columns are provided' do
      validator = described_class.new(file_columns)

      expect(validator.valid?).to eq true
      expect(validator.errors).to be_empty
    end

    it 'return false when one column is missing' do
      validator = described_class.new(file_columns[0..-2])
      message = ["Wrong column value - got empty cell expected BankRoutingNumber"]

      expect(validator.valid?).to eq false
      expect(validator.errors).to eq message
    end

    it 'returns false when multiple columns missing' do
      validator = described_class.new(file_columns[0..-4])
      message = ["Wrong column value - got empty cell expected CheckNumber",
        "Wrong column value - got empty cell expected BankAccountNumber",
        "Wrong column value - got empty cell expected BankRoutingNumber"]

      expect(validator.valid?).to eq false
      expect(validator.errors).to eq message
    end
  end
end
