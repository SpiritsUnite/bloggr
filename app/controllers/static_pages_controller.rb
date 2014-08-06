class StaticPagesController < ApplicationController
  def home
    @posts = Post.where(published: true).order("created_at DESC")
  end
end
