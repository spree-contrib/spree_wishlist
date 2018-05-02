RSpec.feature 'Wished Product', :js do
  given(:user) { create(:user) }

  context 'add' do
    given(:product) { create(:product) }

    background do
      sign_in_as! user
    end

    scenario 'when user has a default wishlist' do
      wishlist = create(:wishlist, is_default: true, user: user)

      add_to_wishlist product

      expect(page).to have_content wishlist.name
      expect(page).to have_content product.name
    end

    scenario 'when user has no default but with non-default wishlist' do
      wishlist = create(:wishlist, is_default: false, user: user)

      add_to_wishlist product

      expect(wishlist.reload.is_default).to be true
      expect(page).to have_content wishlist.name
      expect(page).to have_content product.name
    end

    scenario 'when user has no wishlist at all' do
      expect(user.wishlists).to be_empty

      add_to_wishlist product

      expect(user.wishlists.reload.count).to eq(1)
      expect(page).to have_content user.wishlists.first.name
      expect(page).to have_content product.name
    end

    scenario 'when user chooses different quantity of item' do
      wishlist = create(:wishlist, user: user)

      visit spree.product_path(product)
      fill_in "quantity", with: "15"
      click_button 'Add to wishlist'

      expect(page).to have_content product.name
      expect(page).to have_selector("input[value='15']")
    end
  end

  context 'delete' do
    given(:wishlist) { create(:wishlist, user: user) }

    background do
      sign_in_as! user
    end

    scenario 'from a wishlist with one wished product' do
      wished_product = create(:wished_product, wishlist: wishlist)

      visit spree.wishlist_path(wishlist)

      click_link 'Remove from wishlist'

      expect(page).not_to have_content wished_product.variant.product.name
    end

    scenario 'randomly from a wishlist with multiple wished products while maintaining ordering by date added' do
      allow(Capybara).to receive(:ignore_hidden_elements) { false }
      wished_products = [
        create(:wished_product, wishlist: wishlist),
        create(:wished_product, wishlist: wishlist),
        create(:wished_product, wishlist: wishlist)
      ]
      wished_product = wished_products.delete_at(Random.rand(wished_products.length))

      visit spree.wishlist_path(wishlist)

      wp_path = spree.wished_product_path(wished_product)
      delete_links = find(:xpath, '//table[@id="wishlist"]/tbody').all(:xpath, './/tr/td/p/a')
      delete_link = delete_links.select { |link| link[:href][-wp_path.length..-1] == wp_path }.first
      delete_link.click
      pattern = Regexp.new(wished_products.map { |wp| wp.variant.product.name }.join('.*'))

      expect(page).not_to have_content wished_product.variant.product.name
      expect(page).to have_content pattern
    end
  end

  private

  def add_to_wishlist(product)
    visit spree.product_path(product)
    click_button 'Add to wishlist'
  end
end
