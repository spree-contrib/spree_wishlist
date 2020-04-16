FactoryBot.define do
  factory :user_with_wishlist, parent: :user do
    after :create do |user|
      user << create(:wishlist)
      user.save
      user.reload
    end
  end
end
