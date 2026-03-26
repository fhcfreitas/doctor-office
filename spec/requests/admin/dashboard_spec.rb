require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  let(:admin_user) { create(:user) }

  def sign_in_as(user)
    post session_path, params: {
      email_address: user.email_address,
      password: user.password
    }
  end

  it "allows access to admin dashboard for admin users" do
    sign_in_as(admin_user)

    get admin_root_path
    expect(response).to have_http_status(:ok)
  end

  it "redirects non-admin users from admin dashboard" do
    non_admin_user = create(:user, admin: false)
    sign_in_as(non_admin_user)

    get admin_root_path
    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("Not authorized")
  end
end
