class HomeController < ApplicationController
  def index
    @quadras = Quadra.all
    @users = User.all
    @comments = Comment.all
  end
end
