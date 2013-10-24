FactoryGirl.define do
  factory :customer do
    name     "Example Customer"
    username "customer"
    password "foobar"
    password_confirmation "foobar"
    account_balance 1000
  end


  factory :administrator do
    name     "Example Admin"
    username "admin"
    password "foobar"
    password_confirmation "foobar"
  end

end