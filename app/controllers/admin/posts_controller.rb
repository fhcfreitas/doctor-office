class Admin::PostsController < ApplicationController
  before_action :require_authentication
  before_action :require_admin!
  before_action :set_post, only: %i[ show edit update destroy publish ]
  layout "admin"

  def index
    @filter = params[:filter]

    @posts = case @filter
    when "published" then Post.published
    when "draft" then Post.drafted
    when "newsletter" then Post.where(newsletter_flag: true)
    else Post.all
    end.order(updated_at: :desc).includes(:user).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = Current.user

    if @post.save
      redirect_to admin_post_path(@post), success: "Post Criado."
    else
      render :new, status: :unprocessable_content
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.cover_image.purge if params.dig(:post, :remove_cover_image) == "1"

    safe_params = post_params.except(:remove_cover_image)
    safe_params = safe_params.except(:draft) if @post.published?

    if @post.update(safe_params)
      redirect_to admin_post_path(@post), notice: "Post atualizado."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deletado."
  end

  def publish
    @post.publish!
    redirect_to admin_post_path(@post), notice: "Post publicado."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :subtitle, :content, :draft, :newsletter_flag, :cover_image, :remove_cover_image)
  end
end
