require File.dirname(__FILE__) + '/../spec_helper'

describe Wishlist do
  before(:each) do
    @wishlist = Wishlist.new
  end

  it "should be valid" do
    @wishlist.should be_valid
  end
end
