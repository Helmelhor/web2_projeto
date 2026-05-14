class LikesController < ApplicationController
  def create
    @quadra = Quadra.find(params[:quadra_id])
    # Cria a curtida associada ao usuário logado
    @quadra.likes.find_or_create_by(user: current_user)
    redirect_to home_index_path
  end

  def destroy
    @quadra = Quadra.find(params[:quadra_id])
    # Busca a curtida do usuário logado e apaga
    @like = @quadra.likes.find_by(user: current_user)
    @like.destroy if @like
    redirect_to home_index_path
  end
end
