require File.dirname(__FILE__) + '/../../spec_helper'

describe Spree::WishedProduct do
  before(:each) do
    @wished_product = Spree::WishedProduct.new
  end

  it "should be valid" do
    @wished_product.should be_valid
  end
  
  it "should permit mass assigment of variant_id" do
    lambda {
      Spree::WishedProduct.new :variant_id => 33506
    }.should_not raise_error
    
  end
end
