require 'spec_helper'

describe Spree::Product do
  context "add to wishlist" do
    it "add the selected variant to the wishlist", :js => true do
      user = FactoryGirl.create(:user)
      sign_in_as!(user)

      prod = FactoryGirl.create(:product)
      variant1 = FactoryGirl.create(:variant)
      variant2 = FactoryGirl.create(:variant)
      variant1.product = prod
      variant1.save
      variant2.product = prod
      variant2.save

      visit "/products/#{prod.permalink}"

      find("#products_#{prod.master.id}_#{variant2.id}").click
      click_button("Add to wishlist")
      r = page.evaluate_script("$('#variants_#{variant2.id}').val();")
      r.to_i.should == 1
    end
  end
end