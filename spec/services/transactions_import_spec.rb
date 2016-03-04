require 'rails_helper'

describe TransactionsImport do
  let!(:transaction) { create(:transaction, :with_file_transactions) }
  let(:connection) { nil }
  subject { TransactionsImport.new(transaction, connection).call }
  before do
    allow(Mambu::Savings).to receive(:create_deposit) { true }
    subject
  end
  it { expect(transaction.file_transactions.first.mambu_info.present?).to eq true }
  it { expect(transaction.file_transactions.first.mambu_info.message).to eq 'SUCCESSFULLY PROCESSED' }
  it { expect(transaction.file_transactions.first.mambu_error.present?).to eq false }
end
