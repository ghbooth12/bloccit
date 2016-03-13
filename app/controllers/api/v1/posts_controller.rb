class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, except: [:index, :show]

  def index
    topic = Topic.find(params[:topic_id])
    posts = topic.posts.all

    render json: posts.to_json, status: 200
  end

  def show
    topic = Topic.find(params[:topic_id])
    post = topic.posts.find(params[:id])

    render json: post.to_json, status: 200
  end
end
