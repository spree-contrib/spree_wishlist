RSpec.describe Spree::User, type: :model do

  it { is_expected.to have_many(:wishlists).class_name('Spree::Wishlist') }

  it 'has a valid factory' do
    expect(build(:user_with_wishlist)).to be_valid
  end
end
