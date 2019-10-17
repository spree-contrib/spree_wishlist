module Spree::VariantDecorator
  def self.prepended(base)
    base.has_many :wished_products, dependent: :destroy
  end
end

Spree::Variant.prepend Spree::VariantDecorator
