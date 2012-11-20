require File.dirname(__FILE__) + '/../../spec_helper'

describe Spree::Wishlist do
  before(:each) do
    @user = Factory(:user)
    @wishlist = Spree::Wishlist.new(:user => @user, :name => "My Wishlist")
  end

  context "can't mass assign ids" do
    it "should not be able to assign variant_id" do
      lambda {
        Spree::Wishlist.new(:user_id => @user.id, :name => "My Wishlist")  
      }.should raise_error
    end
  end
  
  context "creating a new wishlist" do
    it "is valid with valid attributes" do
      @wishlist.should be_valid
    end

    it "is not valid without a name" do
      @wishlist.name = nil
      @wishlist.should_not be_valid
    end
  end

  context "#include?" do
    before(:each) do
      @variant = Factory(:variant)
      wished_product = Spree::WishedProduct.new(:variant => @variant)
      @wishlist.wished_products << wished_product
      @wishlist.save
    end

    it "should be true if the wishlist includes the specified variant" do
      @wishlist.include?(@variant.id).should be_true
    end
  end
  
  context "#to_param" do
    it "should return the wishlist's access_hash" do
      @wishlist.to_param.should == @wishlist.access_hash
    end
  end

  context "#can_be_read_by?" do
    context "when the wishlist is private" do
      before(:each) do
        @wishlist.is_private = true
      end

      it "is true when the user owns the wishlist" do
        @wishlist.can_be_read_by?(@user).should be_true
      end

      it "is false when the user does not own the wishlist" do
        other_user = Factory(:user)
        @wishlist.can_be_read_by?(other_user).should be_false
      end
    end

    context "when the wishlist is public" do
      it "is true for any user" do
        @wishlist.is_private = false
        other_user = Factory(:user)
        @wishlist.can_be_read_by?(other_user).should be_true
      end
    end
  end

  context "#is_public?" do
    it "is true when the wishlist is public" do
      @wishlist.is_private = false
      @wishlist.is_public?.should be_true
    end

    it "is false when the wishlist is private" do
      @wishlist.is_private = true
      @wishlist.is_public?.should_not be_true
    end
  end
end
