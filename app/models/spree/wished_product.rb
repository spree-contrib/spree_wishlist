class Spree::WishedProduct < ActiveRecord::Base
  belongs_to :variant
  belongs_to :wishlist

  scope :active, includes(:variant).where("spree_variants.deleted_at IS NULL")

  attr_accessible :variant_id
end
