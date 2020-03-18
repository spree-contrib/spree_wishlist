object false
node(:count) { @wishlists.count }
node(:total_count) { @wishlists.total_count }
node(:current_page) { params[:page].present? ? params[:page].to_i : 1 }
node(:per_page) { params[:per_page].present? ? params[:per_page].to_i : Kaminari.config.default_per_page }
node(:pages) { @wishlists.total_pages }
child(@wishlists => :wishlists)  do
  attributes *wishlist_attributes+[:id]
end
