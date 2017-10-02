class Spree::WishedProduct < ActiveRecord::Base
  belongs_to :variant, optional: true
  belongs_to :wishlist, optional: true

  def total
    quantity * variant.price
  end

  def display_total
    Spree::Money.new(total)
  end

end
