require 'cancan/matchers'

RSpec.describe WishlistAbility do
  let(:user)    { create(:user) }
  let(:ability) { described_class.new(user) }
  let(:token)   { nil }

  subject { ability }

  context 'for Wishlist' do
    context 'when private' do
      let(:resource) { create(:wishlist, is_private: true, user: user) }

      context 'requested by same user' do
        it_should_behave_like 'allow CRUD'
      end

      context 'requested by other user' do
        subject { described_class.new(nil) }
        it_should_behave_like 'access denied'
        it_should_behave_like 'no index allowed'
      end
    end

    context 'when public' do
      let(:resource) { create(:wishlist, is_private: false, user: user) }

      context 'requested by same user' do
        it_should_behave_like 'allow CRUD'
      end

      context 'requested by other user' do
        subject { described_class.new(nil) }
        it_should_behave_like 'read only'
      end
    end
  end

  context 'for Wished Product' do
    let(:resource) do
      create(
        :wished_product,
        wishlist: create(:wishlist, user: user),
        variant:  create(:variant)
      )
    end

    context 'requested by same user' do
      subject { described_class.new(user) }
      it_should_behave_like 'allow CRUD'
    end

    context 'requested by other user' do
      subject { described_class.new(nil) }
      it_should_behave_like 'access denied'
      it_should_behave_like 'no index allowed'
    end
  end
end
