Spree::Variant.class_eval do

  def in_any_stock?
    Spree::Stock::Quantifier.new(self).can_supply?(1)
  end

end
