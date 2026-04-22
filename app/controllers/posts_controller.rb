class PostsController < ApplicationController
  def index
    @posts = Post.published.order(published_at: :desc).includes(:user).page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
  end
end
