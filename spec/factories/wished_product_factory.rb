FactoryBot.define do
  factory :wished_product, class: Spree::WishedProduct do
    variant
    wishlist
    remark 'Some remark..'
  end
end
