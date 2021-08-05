class Post::CommentsController < ApplicationController
  before_action :set_post

  def index
    @pagy, @comments = pagy @post.comments.order(updated_at: :desc)

    render json: { pagination: @pagy, comments: @comments.to_json(include: :user) }
  end

  def create
    comment = @post.comments.build comment_params
    comment.user = current_user

    if comment.save
      render json: { success: true, comment: comment.to_json(include: :user) }
    else
      render json: { success: false, errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
