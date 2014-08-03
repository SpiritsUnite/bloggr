class StaticPagesController < ApplicationController
  def home
    @posts = Post.where(published: true)
  end
end
