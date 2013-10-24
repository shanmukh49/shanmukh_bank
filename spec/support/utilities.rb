def full_title(page_title)
  base_title = "Bank of Kwantlen Online"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(customer)
  visit signin_path
  fill_in "Username",    with: customer.username
  fill_in "Password", with: customer.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = customer.remember_token
end

def admin_sign_in(administrator)
  visit admin_signin_path
  fill_in "Username",    with: administrator.username
  fill_in "Password", with: administrator.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = administrator.remember_token
end
