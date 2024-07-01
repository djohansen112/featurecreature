class CommentsController < ApplicationController
  def create
    @newcomment = Comment.new(comment_params)
    @newcomment.post_id = params[:post_id]
    @newcomment.user_id = current_user.id
    @newcomment.save
    redirect_to post_path(@newcomment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
