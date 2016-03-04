require 'rails_helper'

describe TransactionsReader do
  let!(:transaction) { create(:transaction) }
  let(:opened_file) { Roo::Excelx.new('spec/support/test.xlsx') }
  subject { TransactionsReader.new(opened_file, transaction).call }
  before { subject }

  it { expect(transaction.file_transactions.count).to eq 4 }
  it { expect(transaction.file_transactions.first.account).to eq 'test1' }
  it { expect(transaction.file_transactions.last.account).to eq 'test4' }
end
