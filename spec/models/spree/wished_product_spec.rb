RSpec.describe Spree::WishedProduct, type: :model do
  describe '#quantity' do
    subject { build(:wished_product) }

    it { is_expected.to respond_to(:quantity) }
    it { expect(subject.quantity).to eq(1) }
  end
end
