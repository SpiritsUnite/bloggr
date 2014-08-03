class StaticPagesController < ApplicationController
  def home
    @posts = Post.where(published: true).order("updated_at DESC")
  end
end
