class Api::V1::CommentsController < Api::V1::BaseController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    post = Post.find(params[:post_id])
    comments = post.comments.all

    render json: comments.to_json, status: 200
  end

  def show
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])

    render json: comment.to_json, status: 200
  end
end
