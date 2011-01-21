class WishlistAbility
# stuff like class AbilityDecorator goes here
  include CanCan::Ability

  def initialize(user)
# TODO - this is really soggy (i.e., non-DRY), and it's not all necessary
    # You can only index your own wishlists
    can :index, Wishlist do
      !user.new_record?
    end
    # Anyone can create a wishlist
    can :create, Wishlist
    # You can only see your own wishlist
    can :show, Wishlist do |wishlist|
      wishlist.user == user || !wishlist.is_private?
    end
    # You can only change your own wishlist
    can :move, Wishlist do |wishlist|
      wishlist.user == user
    end
    can :update, Wishlist do |wishlist|
      wishlist.user == user
    end
    can :edit, Wishlist do |wishlist|
      wishlist.user == user
    end

    can :destroy, Wishlist do |wishlist|
      wishlist.user == user
    end

    can :create, WishedProduct do |wished_product|
      !user.new_record?
    end
    can :index, WishedProduct do |wished_product|
      wished_product.wishlist.user == user
    end
    can :show, WishedProduct do |wished_product|
      wished_product.wishlist.user == user || wished_product.wishlist.is_public?
    end
    can :delete, WishedProduct do |wished_product|
      wished_product.wishlist.user == user
    end
    can :update, WishedProduct do |wished_product|
      wished_product.wishlist.user == user
    end
  end
end

