RSpec.describe Spree::Api::V2::Storefront::WishedProductsController, type: :request do
  let(:wishlist)   { create(:wishlist) }
  let(:user)       { wishlist.user }
  let(:product)    { create(:variant) }
  let(:headers)    { headers_bearer }

  include_context 'API v2 tokens'

  context '#create' do

    it 'must permit add product to the default wishlist' do
      post "/api/v2/storefront/wished_products", headers: headers, params: {
        wished_product: {
          variant_id: product.id,
          wishlist_id: wishlist.id
        }
      }
      expect(json['data']['relationships']['variant']['data']['id']).to eq(product.id.to_s)
    end

    it 'will add the item to list identified by `wishlist_id` if passed' do
      other_wishlist = create(:wishlist, user: user)

      post "/api/v2/storefront/wished_products", headers: headers, params: {
        wished_product: {
          variant_id: product.id,
          wishlist_id: other_wishlist.id
        }
      }
      expect(Spree::WishedProduct.count).to eq(1)
      expect(Spree::WishedProduct.last.wishlist_id).to eq(other_wishlist.id)
    end

    it 'can not add product if missing variant' do
      post "/api/v2/storefront/wished_products", headers: headers, params: {
        wished_product: {
          nodata_id: product.id,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response).to have_http_status(422)
    end

  end

  context '#update' do
    let(:bad_user) { create(:user) }
    let(:new_product) { create(:variant) }

    before do
      bad_user.generate_spree_api_key!
      @wished_product = wishlist.wished_products.create( {
        variant_id: product.id
      })
    end

    it 'must permit update wishlist product' do
      put "/api/v2/storefront/wished_products/#{@wished_product.id}", headers: headers, params: {
        wished_product: {
          variant_id: new_product.id,
          wishlist_id: user.wishlist.id
        }
      }
      expect(json['data']['relationships']['variant']['data']['id']).to eq(new_product.id.to_s)
    end

    it 'can not update wishlist with product that not exists' do
      put "/api/v2/storefront/wished_products/#{@wished_product.id}", headers: headers, params: {
        wished_product: {
          variant_id: 9999,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response.status).to eq(422)
    end
  end

  context '#destroy' do
    before do
      @wishes = []
      (0..3).each do
        @wishes << create(:variant)
      end

      @wished_products = []
      @wishes.each do |wish|
        @wished_products << wishlist.wished_products.create( {
          variant_id: wish.id
        })
      end
    end

    it 'must permit remove a product from the list' do

      expect(user.wishlist.wished_products.count).to eq(@wished_products.count)

      delete "/api/v2/storefront/wished_products/#{@wished_products.last.id}", headers: headers
      expect(user.wishlist.wished_products.count).to eq(@wished_products.count - 1)
    end
  end

end
