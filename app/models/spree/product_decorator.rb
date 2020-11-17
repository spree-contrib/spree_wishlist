module Spree::ProductDecorator
  def pre_tax_price
    return price if tax_category.nil?

    tax_rate = tax_category&.tax_rates&.included_in_price&.first
    return price if tax_rate.nil?

    price - (price *  tax_rate.amount)
  end
end
Spree::Product.prepend(Spree::ProductDecorator)
