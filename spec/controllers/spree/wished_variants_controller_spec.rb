RSpec.describe Spree::WishedVariantsController, type: :controller do
  let(:user)           { create(:user) }
  let!(:wished_variant) { create(:wished_variant) }
  let(:attributes)     { attributes_for(:wished_variant) }

  before { allow(controller).to receive(:spree_current_user).and_return(user) }

  context '#create' do
    context 'with valid params' do
      it 'creates a new Spree::WishedVariant' do
        expect {
          spree_post :create, wished_variant: attributes
        }.to change(Spree::WishedVariant, :count).by(1)
      end

      it 'assigns a newly created wished_variant as @wished_variant' do
        spree_post :create, wished_variant: attributes
        expect(assigns(:wished_variant)).to be_a Spree::WishedVariant
        expect(assigns(:wished_variant)).to be_persisted
      end

      it 'redirects to the created wished_variant' do
        spree_post :create, wished_variant: attributes
        expect(response).to redirect_to spree.wishlist_path(Spree::WishedVariant.last.wishlist)
      end

      it 'does not save if wished product already exist in wishlist' do
        variant  = create(:variant)
        wishlist = create(:wishlist, user: user)
        wished_variant = create(:wished_variant, wishlist: wishlist, variant: variant)
        expect {
          spree_post :create, id: wished_variant.id, wished_variant: { wishlist_id: wishlist.id, variant_id: variant.id }
        }.to change(Spree::WishedVariant, :count).by(0)
      end
    end

    context 'with invalid params' do
      it 'raises error' do
        expect { spree_post :create }.to raise_error
      end
    end
  end

  context '#update' do
    context 'with valid params' do
      it 'assigns the requested wished_variant as @wished_variant' do
        spree_put :update, id: wished_variant, wished_variant: attributes
        expect(assigns(:wished_variant)).to eq wished_variant
      end

      it 'redirects to the wished_variant' do
        spree_put :update, id: wished_variant, wished_variant: attributes
        expect(response).to redirect_to spree.wishlist_path(wished_variant.wishlist)
      end
    end

    context 'with invalid params' do
      it 'raises error' do
        expect { spree_put :update }.to raise_error
      end
    end
  end

  context '#destroy' do
    it 'destroys the requested wished_variant' do
      expect {
        spree_delete :destroy, id: wished_variant
      }.to change(Spree::WishedVariant, :count).by(-1)
    end

    it 'redirects to the wished_variants list' do
      spree_delete :destroy, id: wished_variant
      expect(response).to redirect_to spree.wishlist_path(wished_variant.wishlist)
    end

    it 'requires the :id parameter' do
      expect { spree_delete :destroy }.to raise_error
    end
  end
end
