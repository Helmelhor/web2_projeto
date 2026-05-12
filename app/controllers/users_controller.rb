class UsersController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to blog_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "Email ou senha inválidos"
      render "home/login", status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end

  def registrar
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: "Cadastro realizado com sucesso!"
    else
      flash.now[:alert] = user.errors.full_messages.to_sentence
      render "home/registrar", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nome, :email, :password, :password_confirmation)
  end
end
