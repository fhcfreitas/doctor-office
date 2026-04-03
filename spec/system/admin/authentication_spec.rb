# spec/system/admin/authentication_spec.rb
require "rails_helper"

RSpec.describe "Admin authentication", type: :system do
  let(:admin) { create(:user, :admin, password: "password") }

  it "redirects unauthenticated users to the login page" do
    visit admin_root_path
    expect(page).to have_current_path(new_session_path)
  end

  it "permits login with valid credentials" do
    visit new_session_path
    fill_in "E-mail", with: admin.email_address
    fill_in "Senha", with: "password"
    click_button "Entrar"
    expect(page).to have_current_path(admin_root_path)
  end

  it "rejects invalid credentials" do
    visit new_session_path
    fill_in "E-mail", with: admin.email_address
    fill_in "Senha", with: "senha_errada"
    click_button "Entrar"
    expect(page).to have_current_path(new_session_path)
  end

  it "permits logout" do
    visit new_session_path
    fill_in "E-mail", with: admin.email_address
    fill_in "Senha", with: "password"
    click_button "Entrar"
    link = find_link("Sair", href: session_path, visible: :all, match: :first)
    page.execute_script("arguments[0].click()", link)
    expect(page).to have_current_path(new_session_path)
  end
end
