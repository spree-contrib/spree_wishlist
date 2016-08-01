FactoryGirl.define do
  factory :wished_variant, class: Spree::WishedVariant do
    variant
    wishlist
    remark 'Some remark..'
  end
end
