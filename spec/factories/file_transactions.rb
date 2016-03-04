FactoryGirl.define do
  factory :file_transaction do
    account { Faker::Lorem.word }
    amount { rand(1000) }
    date { DateTime.now }
    reference { Faker::Name.name }
    t_type 'DEPOSIT'
  end
end
