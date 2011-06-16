class WishlistAbility
# stuff like class AbilityDecorator goes here
  include CanCan::Ability

  def initialize(user)
    # Anyone can create a wishlist
    can :index, Wishlist do
      !user.new_record?
    end

    can :create, Wishlist
    # You can your own wishlists, and everyone cas see public ones
    can :show, Wishlist do |wishlist|
      wishlist.user == user || wishlist.is_public?
    end
    # You can only change your own wishlist
    can [:show, :move, :update, :edit, :destroy], Wishlist do |wishlist|
      wishlist.user == user
    end

    can :create, WishedProduct do |wished_product|
      !user.new_record?
    end

    can :show, WishedProduct do |wished_product|
      wished_product.wishlist.user == user || wished_product.wishlist.is_public?
    end
    can [:index, :update, :delete], WishedProduct do |wished_product|
      wished_product.wishlist.user == user
    end
  end
end

