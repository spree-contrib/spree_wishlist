RSpec.describe Spree::WishlistsController, type: :controller do
  let(:wishlist)   { create(:wishlist) }
  let(:user)       { wishlist.user }
  let(:attributes) { attributes_for(:wishlist) }

  before { allow(controller).to receive(:spree_current_user).and_return(user) }

  context '#new' do
    it 'assigns a new wishlist as @wishlist' do
      spree_get :new
      expect(assigns(:wishlist)).to be_a_new Spree::Wishlist
    end
  end

  context '#index' do
    it 'assigns all wishlists as @wishlists' do
      spree_get :index
      expect(assigns(:wishlists)).to eq user.wishlists
    end
  end

  context '#edit' do
    it 'assigns the requested wishlist as @wishlist' do
      spree_get :edit, id: wishlist
      expect(assigns(:wishlist)).to eq wishlist
    end
  end

  context '#update' do
    it 'assigns @wishlist' do
      spree_put :update, id: wishlist, wishlist: attributes
      expect(assigns(:wishlist)).to eq wishlist
    end

    context 'when the wishlist updates successfully' do
      it 'redirects to the updated wishlist' do
        spree_put :update, id: wishlist, wishlist: attributes
        expect(response).to redirect_to wishlist
      end

      it 'sets the attributes of @wishlist according to attributes' do
        spree_put :update, id: wishlist, wishlist: attributes
        attributes.each do |attr_name, value|
          expect(assigns(:wishlist).send(attr_name)).to eq value
        end
      end
    end

    context 'when the wishlist fails to update' do
      it 'raise error' do
        expect {
          spree_put :update, id: wishlist, wishlist: {}
        }.to raise_error
      end
    end
  end

  context '#show' do
    it 'assigns the requested wishlist as @wishlist' do
      spree_get :show, id: wishlist
      expect(assigns(:wishlist)).to eq wishlist
    end

    # Regression test for issue #68
    it 'raises record not found on invalid params' do
      expect {
        spree_get :show, id: 'nope'
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context '#default' do
    it 'retrieves the default wishlist of the current user' do
      allow_any_instance_of(Spree::User).to receive(:wishlist)
      spree_get :default
    end

    it 'assigns the default wishlist as @wishlist' do
      spree_get :default
      expect(assigns(:wishlist)).to eq user.wishlist
    end

    it 'renders the wishlists/show template' do
      spree_get :default
      expect(response).to render_template 'spree/wishlists/show'
    end
  end

  context '#create' do
    it 'assigns @wishlist' do
      spree_post :create, wishlist: attributes
      expect(assigns(:wishlist)).to be_a Spree::Wishlist
    end

    it 'sets the current user as the user of @wishlist' do
      spree_post :create, wishlist: attributes
      expect(assigns(:wishlist).user).to eq user
    end

    context 'when the wishlist saves successfully' do
      it 'saves the new wishlist' do
        expect {
          spree_post :create, wishlist: attributes
        }.to change(Spree::Wishlist, :count).by(1)
      end

      it 'redirects to the newly created wishlist' do
        spree_post :create, wishlist: attributes
        expect(response).to redirect_to user.wishlists.last
      end

      it 'sets the attributes of @wishlist according to attributes' do
        spree_post :create, wishlist: attributes
        attributes.each do |attr_name, value|
          expect(assigns(:wishlist).send(attr_name)).to eq value
        end
      end
    end

    context 'when the wishlist fails to save' do
      it 'raise error' do
        expect {
          spree_post :create, wishlist: {}
        }.to raise_error
      end
    end
  end

  context '#destroy' do
    it 'destroys the requested wishlist' do
      expect {
        spree_delete :destroy, id: wishlist
      }.to change(Spree::Wishlist, :count).by(-1)
    end

    it 'redirects to the users account page' do
      spree_delete :destroy, id: wishlist
      expect(response).to redirect_to spree.account_path
    end
  end
end
