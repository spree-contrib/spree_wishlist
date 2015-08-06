class Spree::WishedProduct < ActiveRecord::Base
  belongs_to :variant
  belongs_to :wishlist

  def total
    quantity * variant.price
  end

  def display_total
    Spree::Money.new(total)
  end

end
