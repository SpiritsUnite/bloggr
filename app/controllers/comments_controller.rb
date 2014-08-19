class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    if @comment.save
      add_notice(:success, 'Comment successfully added')
      redirect_to @post
    else
      render "post/show"
    end

  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

end
