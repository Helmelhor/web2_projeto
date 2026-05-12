class HomeController < ApplicationController
  def index
    @quadras = Quadra.all
    @users = User.all
    @comments = Comment.all
  end

  def blog
    @quadras = Quadra.all
    @quadra = Quadra.new
  end

  def login
  end

  def registrar
  end
end
