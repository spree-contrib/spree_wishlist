class Spree::WishedProduct < ActiveRecord::Base
  belongs_to :variant
  belongs_to :wishlist
  
  attr_accessible :wishlist_id, :variant_id
end
