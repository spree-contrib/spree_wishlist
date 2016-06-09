RSpec.describe Spree::Api::WishlistsController, type: :request do
  let(:wishlist)   { create(:wishlist) }
  let(:user)       { wishlist.user }

  before do
    user.generate_spree_api_key!
  end

  context '#new' do

    it 'must require a token access' do
      get "/api/wishlists/new"
      expect(response.status).to eq(401)
    end

    it 'return a list of available attributes' do
      get "/api/wishlists/new?token=#{user.spree_api_key}"
      expect(response).to be_success
      expect(json['attributes'].length).to eq(5)
      expect(json['required_attributes'].length).to eq(1)
    end

  end

  context '#index' do
    let(:santa_claus) { create(:user) }

    before do
      santa_claus.generate_spree_api_key!
      (0..29).each { create(:wishlist, user: santa_claus) }
    end

    it 'must return a list of wishlists paged' do
      get "/api/wishlists?token=#{santa_claus.spree_api_key}"
      expect(response).to be_success
      expect(json['count']).to            eq (25)
      expect(json['total_count']).to      eq (30)
      expect(json['current_page']).to     eq (1)
      expect(json['per_page']).to         eq (25)
      expect(json['pages']).to            eq (2)
      expect(json['wishlists'].length).to eq (25)
    end

    it 'can request different pages' do
      get "/api/wishlists?token=#{santa_claus.spree_api_key}&page=2"
      expect(response).to be_success
      expect(json['count']).to            eq (5)
      expect(json['total_count']).to      eq (30)
      expect(json['current_page']).to     eq (2)
      expect(json['per_page']).to         eq (25)
      expect(json['pages']).to            eq (2)
      expect(json['wishlists'].length).to eq (5)
    end

    it 'can control paging size' do
      get "/api/wishlists?token=#{santa_claus.spree_api_key}&page=2&per_page=10"
      expect(response).to be_success
      expect(json['count']).to            eq (10)
      expect(json['total_count']).to      eq (30)
      expect(json['current_page']).to     eq (2)
      expect(json['per_page']).to         eq (10)
      expect(json['pages']).to            eq (3)
      expect(json['wishlists'].length).to eq (10)
    end

  end

  context '#create' do
    it 'can create a new wishlist' do
      post "/api/wishlists?token=#{user.spree_api_key}", {
        wishlist: {
          name: 'fathers day'
        }
      }
      expect(response).to be_success
      expect(user.wishlists.count).to eq(2)
      expect(user.wishlists.last.name).to eq('fathers day')
    end

    it 'must require a name to create a wishlist' do
      post "/api/wishlists?token=#{user.spree_api_key}", {
        wishlist: {
          bad_name: 'fathers day'
        }
      }
      expect(response.status).to eq(422)
      expect(json['error']).not_to be_empty
      expect(json['errors']['name']).not_to be_empty
    end
  end

  context '#update' do
    let(:bad_user) { create(:user) }

    before do
      bad_user.generate_spree_api_key!
    end

    it 'must permit update wishlist name' do
      put "/api/wishlists/#{user.wishlist.access_hash}?token=#{user.spree_api_key}", {
        wishlist: {
          name: 'books'
        }
      }
      expect(response.status).to eq(200)
      user.wishlist.reload
      expect(user.wishlist.name).to eq('books')
    end

    it 'can not permit a user update update lists that not belong to him' do
      put "/api/wishlists/#{user.wishlist.access_hash}?token=#{bad_user.spree_api_key}", {
        wishlist: {
          name: 'books'
        }
      }
      expect(response.status).to eq(401)
    end
  end

  context '#destroy' do
    let(:bad_user) { create(:user) }

    before do
      bad_user.generate_spree_api_key!
    end

    it 'must permite remove a wishlist' do
      delete "/api/wishlists/#{user.wishlist.access_hash}?token=#{user.spree_api_key}"
      expect(response.status).to      eq (204)
      expect(user.wishlists.count).to eq (0)
    end

    it 'can not permite remove a wishlist from another user' do
      delete "/api/wishlists/#{user.wishlist.access_hash}?token=#{bad_user.spree_api_key}"
      expect(response.status).to      eq (401)
    end

  end

end
