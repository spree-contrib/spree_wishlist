module CapybaraExt
  def sign_in_as!(user)
    visit spree.login_path
    within '#new_spree_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end

    core_version = Gem.loaded_specs['spree_core'].version

    if core_version >= Gem::Version.create('4.1.0') && core_version < Gem::Version.create('4.2.0')
      click_button 'Log in'
    else
      click_button 'Login'
    end
  end
end

RSpec.configure do |c|
  c.include CapybaraExt
end
