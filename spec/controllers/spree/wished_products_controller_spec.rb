RSpec.describe Spree::WishedProductsController, type: :controller do
  let(:user)           { create(:user) }
  let!(:wished_product) { create(:wished_product) }
  let!(:variant) { create(:variant) }
  let(:attributes)     { attributes_for(:wished_product).merge(variant_id: variant.id) }

  before { allow(controller).to receive(:spree_current_user).and_return(user) }

  context '#create' do
    context 'with valid params' do
      it 'creates a new Spree::WishedProduct' do
        expect {
          post :create, params: { wished_product: attributes }
        }.to change(Spree::WishedProduct, :count).by(1)
      end

      it 'assigns a newly created wished_product as @wished_product' do
        post :create, params: { wished_product: attributes }
        expect(assigns(:wished_product)).to be_a Spree::WishedProduct
        expect(assigns(:wished_product)).to be_persisted
      end

      it 'redirects to the created wished_product' do
        post :create, params: { wished_product: attributes }
        expect(response).to redirect_to spree.wishlist_path(Spree::WishedProduct.last.wishlist)
      end

      it 'does not save if wished product already exist in wishlist' do
        variant  = create(:variant)
        wishlist = create(:wishlist, user: user)
        wished_product = create(:wished_product, wishlist: wishlist, variant: variant)
        expect {
          post :create, params: { id: wished_product.id, wished_product: { wishlist_id: wishlist.id, variant_id: variant.id }}
        }.to change(Spree::WishedProduct, :count).by(0)
      end
    end

    context 'with invalid params' do
      it 'raises error' do
        expect { post :create }.to raise_error StandardError
      end
    end
  end

  context '#update' do
    context 'with valid params' do
      it 'assigns the requested wished_product as @wished_product' do
        put :update, params: { id: wished_product, wished_product: attributes }
        expect(assigns(:wished_product)).to eq wished_product
      end

      it 'redirects to the wished_product' do
        put :update, params: { id: wished_product, wished_product: attributes }
        expect(response).to redirect_to spree.wishlist_path(wished_product.wishlist)
      end
    end

    context 'with invalid params' do
      it 'raises error' do
        expect { put :update }.to raise_error StandardError
      end
    end
  end

  context '#destroy' do
    it 'destroys the requested wished_product' do
      expect {
        delete :destroy, params: {  id: wished_product }
      }.to change(Spree::WishedProduct, :count).by(-1)
    end

    it 'redirects to the wished_products list' do
      delete :destroy, params: { id: wished_product }
      expect(response).to redirect_to spree.wishlist_path(wished_product.wishlist)
    end

    it 'requires the :id parameter' do
      expect { delete :destroy }.to raise_error StandardError
    end
  end
end
