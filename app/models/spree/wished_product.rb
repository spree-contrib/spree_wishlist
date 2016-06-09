class Spree::WishedProduct < ActiveRecord::Base
  belongs_to :variant
  belongs_to :wishlist

  validate :variant_exists, :wishlist_exists

  private

  def variant_exists
    if Spree::Variant.where(id: self.variant_id).count == 0
      errors.add(:variant, 'invalid variant id')
    end
  end

  def wishlist_exists
    if Spree::Wishlist.where(id: self.wishlist_id).count == 0
      errors.add(:wishlist, 'invalid wishlist id')
    end
  end

end
