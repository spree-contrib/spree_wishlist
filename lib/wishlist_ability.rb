class WishlistAbility

  # Stuff like class AbilityDecorator goes here.

  include CanCan::Ability

  def initialize(user)
    # Anyone can create a wishlist
    can :index, Spree::Wishlist do
      !user.new_record?
    end

    can :create, Spree::Wishlist
    # You can your own wishlists, and everyone cas see public ones
    can :read, Spree::Wishlist do |wishlist|
      wishlist.user == user || wishlist.is_public?
    end
    # You can only change your own wishlist
    can [:read, :move, :update, :edit, :destroy], Spree::Wishlist do |wishlist|
      wishlist.user == user
    end

    can :create, Spree::WishedProduct do |wished_product|
      !user.new_record?
    end

    can :read, Spree::WishedProduct do |wished_product|
      wished_product.wishlist.user == user || wished_product.wishlist.is_public?
    end
    can [:index, :update, :delete], Spree::WishedProduct do |wished_product|
      wished_product.wishlist.user == user
    end
  end
end

