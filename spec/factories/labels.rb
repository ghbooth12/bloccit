FactoryGirl.define do
  factory :label do
    sequence(:name){|n| "Lable-#{n}"}
  end
end
