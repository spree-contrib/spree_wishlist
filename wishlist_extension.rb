# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class WishlistExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/wishlist"

  # Please use wishlist/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    User.class_eval do
      has_many :wishlists
      
      def wishlist
        default_wishlist = self.wishlists.first(:conditions => ["is_default = ?", true]) 
        default_wishlist ||= self.wishlists.first
        default_wishlist ||= self.wishlists.create(:name => "My wishlist", :is_default => true)
        default_wishlist.update_attribute(:is_default, true) unless default_wishlist.is_default?
        default_wishlist
      end
    end

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
  end
end
