require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.twitter_handle { Faker::Internet.user_name }
    f.email { Faker::Internet.email }
    f.word_count(0)
    f.provider(:twitter)
  end
end