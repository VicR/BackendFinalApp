FactoryBot.define do
  factory :product_sale do
    product
    client
    sale_date '2017-02-29'
    quantity 15
  end
end
