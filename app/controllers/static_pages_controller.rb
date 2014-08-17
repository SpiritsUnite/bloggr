class StaticPagesController < ApplicationController
  def home
    @posts = Post.where(published: true).order("created_at DESC").page(params[:page]).per_page(5)
  end
end
