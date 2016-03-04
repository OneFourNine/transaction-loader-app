require 'rails_helper'

describe TransactionsValidator do
  let(:transaction) { create(:transaction, :with_file_transactions) }
  subject { TransactionsValidator.new(transaction.file_transactions).valid? }

  context 'with valid data' do
    it { is_expected.to eq true }
  end

  context 'with invalid data' do
    it 'account name with space before' do
      transaction.file_transactions.first.update(account: ' John')
      is_expected.to eq false
    end

    it 'account name with space after' do
      transaction.file_transactions.first.update(account: 'John ')
      is_expected.to eq false
    end

    it 'account referece with space before and before' do
      transaction.file_transactions.first.update(reference: ' Mr. John ')
      is_expected.to eq false
    end
  end
end
