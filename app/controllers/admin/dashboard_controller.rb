class Admin::DashboardController < ApplicationController
  before_action :require_authentication
  before_action :require_admin!
  layout "admin"

  def index
    @session = Current.session
    @posts_count = Post.count
    @published_posts_count = Post.where(draft: false).count
    @draft_posts_count = Post.where(draft: true).count
  end
end
