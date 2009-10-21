require File.dirname(__FILE__) + '/../spec_helper'

describe WishedProduct do
  before(:each) do
    @wished_product = WishedProduct.new
  end

  it "should be valid" do
    @wished_product.should be_valid
  end
end
