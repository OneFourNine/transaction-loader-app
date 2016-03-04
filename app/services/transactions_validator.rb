class TransactionsValidator
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def valid?
    !perform_validations.include?(false)
  end

  private

  def perform_validations
    transactions.map(&:valid?)
  end
end
