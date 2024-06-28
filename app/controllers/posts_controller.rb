class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show update destroy edit]

  def index
    @posts = user_signed_in? ? Post.sorted : Post.published.sorted
    @pagy, @posts = pagy(@posts)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def edit; end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published_at, :cover_image)
  end

  def set_post
    @post = user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
