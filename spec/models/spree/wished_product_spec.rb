require 'spec_helper'

describe Spree::WishedProduct do
  let(:wished_product) { create(:wished_product) }

  it { should belong_to(:variant) }
  it { should belong_to(:wishlist) }

  it 'has a valid factory' do
    expect(build(:wished_product)).to be_valid
  end
end