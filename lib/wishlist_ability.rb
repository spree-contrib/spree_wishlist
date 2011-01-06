class WishlistAbility
# stuff like class AbilityDecorator goes here
  include CanCan::Ability

  def initialize(user)
# TODO - this is really soggy (i.e., non-DRY), and it's not all necessary
    can :index, Wishlist do |wishlist|
      wishlist.user == user
    end
    can :create, Wishlist do |wishlist|
      wishlist.user == user
    end
    can :show, Wishlist do |wishlist|
      wishlist.user == user
    end
    can :update, Wishlist do |wishlist|
      wishlist.user == user
    end
    can :edit, Wishlist do |wishlist|
      wishlist.user == user
    end
  end
end

