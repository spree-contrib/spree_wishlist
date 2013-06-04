Spree::Variant.class_eval do

  def in_any_stock?
    stock_items.map(&:in_stock?).include?(true)
  end

end
