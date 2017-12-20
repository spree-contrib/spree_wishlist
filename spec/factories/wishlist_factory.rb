FactoryBot.define do
  factory :wishlist, class: Spree::Wishlist do
    user
    sequence(:name) { |n| "Wishlist_#{n}" }
    is_private true
    is_default false
  end
end
