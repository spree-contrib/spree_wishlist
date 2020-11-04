RSpec.describe Spree::Api::V2::Storefront::WishlistsController, type: :request do
  let(:wishlist)   { create(:wishlist) }
  let(:user)       { wishlist.user }
  let(:headers)    { headers_bearer }

  include_context 'API v2 tokens'

  context '#index' do
    let!(:wishlists) { create_list(:wishlist, 30, user: user) }

    it 'must return a list of wishlists paged' do
      get "/api/v2/storefront/wishlists", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['data'].count).to eq (25)
    end

    it 'can request different pages' do
      get "/api/v2/storefront/wishlists?page=2", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['data'].count).to eq (6)
    end

    it 'can control paging size' do
      get "/api/v2/storefront/wishlists?page=2&per_page=10", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['data'].count).to eq (10)
    end
  end

  context '#show' do
    let!(:wished_product) {
      wishlist.wished_products.create({ variant_id: create(:variant).id })
    }

    it 'returns wish list details' do
      get "/api/v2/storefront/wishlists/#{wishlist.access_hash}?include=wished_products", headers: headers
      expect(response).to have_http_status(:ok)
      expect(json['data']['attributes']['access_hash']).to                 eq (wishlist.access_hash)
      expect(json['data']['attributes']['name']).to                        eq (wishlist.name)
      expect(json['data']['attributes']['is_private']).to                  eq (wishlist.is_private?)
      expect(json['data']['attributes']['is_default']).to                  eq (wishlist.is_default?)
      expect(json['data']['relationships']['wished_products']['data'].first['id']).to eq(wished_product.id.to_s)
    end
  end

  context '#create' do
    it 'can create a new wishlist' do
      post "/api/v2/storefront/wishlists", headers: headers,  params: {
        wishlist: {
          name: 'fathers day'
        }
      }
      expect(user.wishlists.count).to eq(2)
      expect(user.wishlists.last.name).to eq('fathers day')
    end

    it 'must require a name to create a wishlist' do
      post "/api/v2/storefront/wishlists", headers: headers,  params: {
        wishlist: {
          bad_name: 'fathers day'
        }
      }
      expect(response.status).to eq(422)
      expect(json['error']).not_to be_empty
      expect(json['error']).to eq "Name can't be blank"
    end
  end

  context '#update' do
    it 'must permit update wishlist name' do
      put "/api/v2/storefront/wishlists/#{user.wishlist.access_hash}", headers: headers,  params: {
        wishlist: {
          name: 'books'
        }
      }
      expect(response.status).to eq(200)
      user.wishlist.reload
      expect(user.wishlist.name).to eq('books')
    end
  end

  context '#destroy' do
    it 'must permite remove a wishlist' do
      delete "/api/v2/storefront/wishlists/#{user.wishlist.access_hash}", headers: headers
      expect(response.status).to      eq (200)
      expect(user.wishlists.count).to eq (0)
    end
  end

end
