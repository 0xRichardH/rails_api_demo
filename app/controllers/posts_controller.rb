class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @pagy, @posts = pagy(Post.order(updated_at: :desc))

    render json: { pagination: @pagy, posts: @posts.to_json(include: :author) }
  end

  def show
    render json: @post.to_json(include: :author)
  end

  def create
    post = current_user.posts.build post_params

    if post.save
      render json: { success: true, post: post.to_json(include: :author) }
    else
      render json: { success: false, errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: { success: true, post: @post.to_json(include: :author) }
    else
      render json: { success: false, errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
