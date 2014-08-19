class PostsController < ApplicationController
  before_action :set_post

  def show
    @comment = Comment.new
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

end
