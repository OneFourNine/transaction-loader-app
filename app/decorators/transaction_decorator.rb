class TransactionDecorator < Draper::Decorator
  delegate_all

  def mambu_transactions_count
    object.file_transactions.count
  end

  def successful_transactions_count
    object.successful_transactions.count
  end

  def failure_transactions_count
    object.failure_transactions.count
  end
end
