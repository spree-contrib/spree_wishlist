RSpec.describe Spree::WishedProduct, type: :model do
  it 'is valid without a variant' do
    wished_product = build(:wished_product, variant: nil)

    expect(wished_product).to be_valid
  end

  it 'is valid without a wishlist' do
    wished_product = build(:wished_product, wishlist: nil)

    expect(wished_product).to be_valid
  end

  describe '#quantity' do
    subject { build(:wished_product) }

    it { is_expected.to respond_to(:quantity) }
    it { expect(subject.quantity).to eq(1) }
  end
end
