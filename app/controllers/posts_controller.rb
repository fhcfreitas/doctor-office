class PostsController < ApplicationController
  def index
    @search = params[:q]

    @posts = Post.all
    @posts = @posts.where("title LIKE ? OR subtitle LIKE ?", "%#{@search}%", "%#{@search}%") if @search.present?
    @posts = @posts.published.order(published_at: :desc).includes(:user).page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
  end
end
