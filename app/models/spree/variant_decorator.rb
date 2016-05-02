Spree::Variant.class_eval do
  has_many :wished_variants, dependent: :destroy
end
