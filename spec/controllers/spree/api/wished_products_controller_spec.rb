RSpec.describe Spree::Api::WishedProductsController, type: :request do
  let(:wishlist)   { create(:wishlist) }
  let(:user)       { wishlist.user }
  let(:product)    { create(:variant) }

  before do
    user.generate_spree_api_key!
  end

  context '#create' do

    it 'must permit add product to the default wishlist' do
      post "/api/wished_products?token=#{user.spree_api_key}", {
        wished_product: {
          variant_id: product.id,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response).to be_success
      expect(json['wished_products'].length).to eq(1)
      expect(json['wished_products'][0]['variant_id']).to eq(product.id)
    end

    it 'can not add product if missing variant' do
      post "/api/wished_products?token=#{user.spree_api_key}", {
        wished_product: {
          nodata_id: product.id,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response).not_to be_success
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
      put "/api/wished_products/#{@wished_product.id}?token=#{user.spree_api_key}", {
        wished_product: {
          variant_id: new_product.id,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response).to be_success
      expect(json['wished_products'][0]['variant_id']).to eq(new_product.id)
    end

    it 'can not update wishlist with product that not exists' do
      put "/api/wished_products/#{@wished_product.id}?token=#{user.spree_api_key}", {
        wished_product: {
          variant_id: 9999,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response.status).to eq(422)
    end

    it 'can not update wishlist from another user' do
      put "/api/wished_products/#{@wished_product.id}?token=#{bad_user.spree_api_key}", {
        wished_product: {
          variant_id: 9999,
          wishlist_id: user.wishlist.id
        }
      }
      expect(response.status).to eq(401)
    end

  end

  context '#destroy' do
    let(:bad_user) { create(:user) }

    before do
      bad_user.generate_spree_api_key!

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

      delete "/api/wished_products/#{@wished_products.last.id}?token=#{user.spree_api_key}"
      expect(response).to be_success
      expect(user.wishlist.wished_products.count).to eq(@wished_products.count - 1)
    end

    it 'can not permit remove products from another user' do

      expect(user.wishlist.wished_products.count).to eq(@wished_products.count)

      delete "/api/wished_products/#{@wished_products.last.id}?token=#{bad_user.spree_api_key}"
      expect(response.status).to eq(401)
    end

  end

end
