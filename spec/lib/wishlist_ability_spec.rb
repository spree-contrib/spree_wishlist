require 'spec_helper'
require 'cancan/matchers'

describe WishlistAbility do

  let(:user) { User.new }
  let(:ability) { Ability.new(user) }
  let(:token) { nil }

  TOKEN = "token123"

  after(:each) { Ability.abilities = Set.new }

  shared_examples_for "allow CRUD" do
    it "should allow create" do
      ability.should be_able_to(:create, resource, token)
    end
    it "should allow read" do
      ability.should be_able_to(:read, resource, token)
    end
    it "should allow update" do
      ability.should be_able_to(:update, resource, token)
    end
    it "should allow destroy" do
      ability.should be_able_to(:destroy, resource, token)
    end
  end

  shared_examples_for "access denied" do
    it "should not allow read" do
      ability.should_not be_able_to(:read, resource)
    end
    it "should not allow create" do
      ability.should_not be_able_to(:create, resource)
    end
    it "should not allow update" do
      ability.should_not be_able_to(:update, resource)
    end
  end

  shared_examples_for "no index allowed" do
    it "should not allow index" do
      ability.should_not be_able_to(:index, resource)
    end
  end

  shared_examples_for "create only" do
    it "should allow create" do
      ability.should be_able_to(:create, resource)
    end
    it "should not allow read" do
      ability.should_not be_able_to(:read, resource)
    end
    it "should not allow update" do
      ability.should_not be_able_to(:update, resource)
    end
    it "should not allow index" do
      ability.should_not be_able_to(:index, resource)
    end
  end

  shared_examples_for "read only" do
    it "should not allow create" do
      ability.should_not be_able_to(:create, resource)
    end
    it "should allow read" do
      ability.should be_able_to(:read, resource)
    end
    it "should not allow update" do
      ability.should_not be_able_to(:update, resource)
    end
    it "should allow index" do
      ability.should be_able_to(:index, resource)
    end
  end

  context "for Wishedproduct" do
  end

  context "for Wishlist" do
    context "private" do
      let(:resource) { Wishlist.new(:is_private => true) }
      pending
    end

    context "public" do
      let(:resource) { Wishlist.new(:is_private => false) }
      context "requested by same user" do
        before { resource.user = user }
        pending
        it_should_behave_like "allow CRUD"
      end
      context "requested by other user" do
        pending
      end

    end
  end
end
