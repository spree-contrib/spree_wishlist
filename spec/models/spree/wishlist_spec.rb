require File.dirname(__FILE__) + '/../../spec_helper'

describe Spree::Wishlist do
  before(:each) do
    @wishlist = Spree::Wishlist.new(:name => 'test')
  end

  it "should be valid" do
    @wishlist.should be_valid
  end
end
