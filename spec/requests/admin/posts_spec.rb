require 'rails_helper'

RSpec.describe "Admin::Posts", type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:the_post) { create(:post, user: admin_user) }

  before do
    sign_in_as(admin_user)
    expect(response).not_to redirect_to("/session/new")
  end

  describe "GET /admin/posts" do
    it "returns http success" do
      get admin_posts_path
      expect(response).to have_http_status(:success)
    end

    it "lists posts" do
      the_post
      get admin_posts_path
      expect(response.body).to include(the_post.title)
    end
  end

  describe "GET /admin/posts/new" do
    it "returns http success" do
      get new_admin_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /admin/posts" do
    context "with valid params" do
      it "creates new post and redirects to post show page" do
        post admin_posts_path, params: {
          post: {
            title: "New Post",
            content: "Post content"
          }
        }
        expect(response).to redirect_to(admin_post_path(Post.last))
      end
    end

    context "with invalid params" do
      it "renders new template unprocessable_entity" do
        post admin_posts_path, params: {
          post: {
            content: "Post content"
          }
        }

        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "PATCH /admin/posts/:id" do
    it "updates the post and redirects" do
      patch admin_post_path(the_post), params: { post: { title: "Título Atualizado" } }
      expect(response).to redirect_to(admin_post_path(the_post))
      expect(the_post.reload.title).to eq("Título Atualizado")
    end

    it "renders edit with invalid params" do
      patch admin_post_path(the_post), params: { post: { title: "" } }
      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("Salvar alterações")
    end
  end

  describe "DELETE /admin/posts/:id" do
    it "deletes the post and redirects to index" do
      the_post
      expect {
        delete admin_post_path(the_post)
      }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(admin_posts_path)
    end
  end

  private

 def sign_in_as(user)
  post "/session", params: {
    email_address: user.email_address,
    password: "password"
  }
    follow_redirect! if response.redirect?
  end
end
