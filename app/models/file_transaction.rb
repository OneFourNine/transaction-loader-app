class FileTransaction < ActiveRecord::Base
  validates :account, :amount, :t_type, :date, presence: true
  validates :account, :reference, :t_type, :transaction_channel, :identifier, :account_name,
    :receipt_number, :bank_number, :check_number, :bank_account_number,
    :bank_routing_number, length: { maximum: 1024 }
  validate :method_type
  validate :check_spaces

  belongs_to :main_transaction, class_name: 'Transaction'
  has_one :mambu_error
  has_one :mambu_info

  def method_type
    unless t_type.try(:upcase) == 'DEPOSIT'
      errors.add(:transaction, 'Invalid method type')
    end
  end

  def check_spaces
    string_attributes.each do |attribute|
      next if send(attribute) == send(attribute).try(:strip)
      errors.add(attribute.to_sym, 'includes redundant spaces')
      logger.info "The excel file contains unneeded spaces in fields. Remove them and try again"
    end
  end

  def string_attributes
    attributes.keys - NON_STRING_COLUMN
  end

  def hasherize
    attributes.to_hash.symbolize_keys.
      except(:id, :created_at, :updated_at, :reference, :account, :transaction_id).
      reject { |k,v| v.nil? || v.blank? }
  end

  def successful?
    mambu_error.nil?
  end

  def failure?
    mambu_error.present?
  end

  COLUMN_NAMES = %w(
    Account
    Amount
    Date
    Reference
    Type
    TransactionChannel
    Identifier
    AccountName
    ReceiptNumber
    BankNumber
    CheckNumber
    BankAccountNumber
    BankRoutingNumber
  )

  NON_STRING_COLUMN = %w(
    id
    amount
    date
    transaction_id
    created_at
    updated_at
    imported
  )
end
