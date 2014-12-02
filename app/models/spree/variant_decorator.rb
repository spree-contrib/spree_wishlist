Spree::Variant.class_eval do
  has_many :wished_products, dependent: :destroy
end
