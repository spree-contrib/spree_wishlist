RSpec.describe Spree::WishedVariant, type: :model do

  it { is_expected.to belong_to(:variant) }
  it { is_expected.to belong_to(:wishlist) }

  it 'has a valid factory' do
    expect(build(:wished_variant)).to be_valid
  end

  describe '#quantity' do
    subject { build(:wished_variant) }

    it { is_expected.to respond_to(:quantity) }
    it { expect(subject.quantity).to eq(1) }
  end
end
