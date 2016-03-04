FactoryGirl.define do
  factory :transaction do
    excel_file { Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec', 'support', 'test.xlsx'))
    }
  end

  trait :with_file_transactions do
    file_transactions { create_list(:file_transaction, 3) }
  end
end
