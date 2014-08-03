class Dashboard::PostsController < ApplicationController
  before_action :check_sign_in
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if params[:commit] == "Publish"
      @post.published = true
    else
      @post.published = false
    end

    if @post.save
      add_notice(:success, 'Post successfully saved')
      redirect_to dashboard_path
    else
      render action: 'new'
    end
  end

  def update
    unless @post.author == current_user
      add_notice(:danger, 'You are not allowed to edit that post')
      redirect_to dashboard_path
    end

    if params[:commit] == "Publish"
      @post.published = true
    elsif params[:commit] =~ /draft/i
      @post.published = false
    end

    if @post.update(post_params)
      add_notice(:success, 'You have successfully updated the post.')
      redirect_to dashboard_path
    else
      render action: 'edit'
    end
  end

  def destroy
    unless @post.author == current_user
      add_notice(:danger, 'You are not allowed to delete that post')
      redirect_to dashboard_path
    end
    @post.destroy
    add_notice(:success, 'Post successfully deleted')
    redirect_to dashboard_path
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
