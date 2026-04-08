class PagesController < ApplicationController
  skip_before_action :require_authentication, only: [ :home ]

  def home
    @posts = Post.published.order(published_at: :desc).limit(3)
  end
end
