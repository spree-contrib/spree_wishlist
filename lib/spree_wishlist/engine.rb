module SpreeWishlist
  class Engine < Rails::Engine
    engine_name 'spree_wishlist'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      cache_klasses = %W(#{config.root}/app/**/*_decorator*.rb #{config.root}/app/overrides/*.rb)
      Dir.glob(cache_klasses) do |klass|
        Rails.configuration.cache_classes ? require(klass) : load(klass)
      end
      Spree::Ability.register_ability(WishlistAbility)
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
