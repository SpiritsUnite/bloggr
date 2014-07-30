FactoryGirl.define do
  factory :user do
    username "aoeu"
    email    "test@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end