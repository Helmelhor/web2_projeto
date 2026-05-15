class Admin::UsersController < ApplicationController
  # before_action :authorize # Descomente se tiver um sistema de proteção

  def index
    @users = User.all.order(created_at: :desc)
    # Inicia um usuário vazio para o formulário de "Novo Usuário"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "Usuário criado com sucesso!"
    else
      # Se der erro, recarrega a lista e a mesma tela (index)
      @users = User.all.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @users = User.all.order(created_at: :desc)
    # Busca o usuário clicado para preencher o formulário
    @user = User.find(params[:id])
    # Força o Rails a usar o arquivo index.html.erb ao invés do edit.html.erb
    render :index
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Usuário atualizado com sucesso!"
    else
      @users = User.all.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "Usuário apagado."
  end

  private

  def user_params
    params.require(:user).permit(:nome, :email, :password, :password_confirmation)
  end
end
