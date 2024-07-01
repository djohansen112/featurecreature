class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show showcategory]
  before_action :set_categories
  before_action :set_comments
  before_action :set_post, only: %i[show update destroy edit]

  def index
    @posts = if user_signed_in?
               if current_user.role_id == 1
                 Post.all.sorted
               else
                 Post.published.sorted
               end
             else
               Post.published.sorted
             end
    @pagy, @posts = pagy(@posts)
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def show
    @comments = Comment.where(post_id: params[:id])
    @newcomment = Comment.new
    @newcomment.post_id = @post.id
  end

  def showcategory
    @categories = Category.find_by_name(params[:name])
  end

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
    params.require(:post).permit(:title, :content, :published_at, :cover_image, :category_id)
  end

  def set_post
    @post = user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def set_categories
    @categories = Category.all
  end

  def set_comments
    @comments = Comment.all
  end
end
