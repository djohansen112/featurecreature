class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show showcategory categories about contact]
  before_action :set_categories
  before_action :set_comments
  before_action :set_post, only: %i[show update destroy edit]

  def categories
    set_categories
  end

  def about; end

  def contact; end

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
    @featured = Post.published.last
    @randompost = Post.published.sample
    @popularpost = Post.published.sample

    quotearray = ['...it\'s a new feature. Don\'t tell anyone it was an accident — Larry Wall',
                  'One man\'s crappy software is another man\'s job - Alan Perlis',
                  'Programming is like sex. One mistake and you have to support it for the rest of your life — Michael Sinz',
                  'There are two ways to write error-free programs; only the third one works. — Alan J. Perlis',
                  'The only thing more expensive than writing software is writing bad software. — Anonymous',
                  'The best thing about a boolean is even if you are wrong, you are only off by a bit. — Anonymous',
                  'Quality is not an act, it is a habit - Aristotle',
                  'Any decent tester has the heart of a developer... in a jar on their desk - Anonymous',
                  'It\'s not working as intended, but it is working as coded - Anonymous',
                  'The most dangerous phrase in the language is, We\'ve always done it this way — Grace Hopper',
                  'Programming isn\'t about what you know; it\'s about what you can figure out — Chris Pine',
                  'Code is like humor. When you have to explain it, it\'s bad. — Cory House',
                  'The best error message is the one that never shows up. — Anonymous',
                  'Programmers never die; they just go offline — Anonymous',
                  'Programming is the art of telling a computer what to do — Anonymous']
    @randquote = quotearray[rand(quotearray.length)]
  rescue Pagy::OverflowError
    redirect_to root_path(page: 1)
  end

  def show
    @comments = Comment.where(post_id: params[:id])
    @newcomment = Comment.new
    @newcomment.post_id = @post.id
    @popularpost = Post.published.sample
  end

  def showcategory
    categories = Category.find_by_name(params[:name])
    if categories
      @categories = Category.find_by_name(params[:name])
    else
      redirect_to root_path
    end
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
