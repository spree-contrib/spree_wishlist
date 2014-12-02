RSpec.describe Spree::WishedProduct, type: :model do

  it { is_expected.to belong_to(:variant) }
  it { is_expected.to belong_to(:wishlist) }

  it 'has a valid factory' do
    expect(build(:wished_product)).to be_valid
  end
end
