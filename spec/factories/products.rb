FactoryBot.define do
  factory :product do
    model { Faker::Commerce.product_name }
    product_type { Faker::Number.between(0, 4) }
    inventory { Faker::Number.between(1, 50) }
    price { Faker::Number.decimal(4, 2) }
    high_tech { Faker::Number.between(0, 1) }
    rentable { Faker::Number.between(0, 1) }

    trait :cpu do
      product_type Product::ProductType::CPU
    end
    trait :printer do
      product_type Product::ProductType::PRINTER
    end
    trait :monitor do
      product_type Product::ProductType::MONITOR
    end
    trait :hdd do
      product_type Product::ProductType::HDD
    end
    trait :other do
      product_type Product::ProductType::OTHER
    end
  end
end
