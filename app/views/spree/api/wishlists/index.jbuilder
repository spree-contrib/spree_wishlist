json.set! :wishlists do
  json.array! @wishlists, *wishlist_attributes
end
json.count @wishlists.count
json.total_count @wishlists.total_count
json.current_page params[:page] ? params[:page].to_i : 1
json.per_page params[:per_page] || Kaminari.config.default_per_page
json.pages @wishlists.num_pages
