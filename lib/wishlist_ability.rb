class WishlistAbility
  include CanCan::Ability

  def initialize(user)
    user ||= Spree::User.new # correct?

    # Anyone can create a wishlist
    can :create, Spree::Wishlist do
      !user.new_record?
    end

    # Anyone can index wishlist
    can :index, Spree::Wishlist do
      !user.new_record?
    end

    # Anyone can add wished product to wishlist
    can :create, Spree::WishedProduct do
      !user.new_record?
    end

    # You can your own wishlists, and everyone cas see public ones
    can :read, Spree::Wishlist do |wishlist|
      wishlist.user == user || wishlist.is_public?
    end

    # You can only change your own wishlist
    can [:read, :move, :update, :edit, :destroy], Spree::Wishlist do |wishlist|
      wishlist.user == user
    end

    # You can only view own wishlist product unless wishlist public
    can :read, Spree::WishedProduct do |wished_product|
      wished_product.wishlist.user == user || wished_product.wishlist.is_public?
    end

    # You can only browse or change own wishlist product
    can [:index, :update, :destroy], Spree::WishedProduct do |wished_product|
      wished_product.wishlist.user == user
    end
  end
end
