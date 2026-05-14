class CommentsController < ApplicationController
  def create
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.build(comment_params)
    @comment.user_id = current_user.id # Puxando do seu sistema de login

    if @comment.save
      redirect_back fallback_location: home_index_path, notice: "Avaliação adicionada!"
    else
      redirect_back fallback_location: home_index_path, alert: "Erro ao adicionar avaliação."
    end
  end

  def destroy
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.find(params[:id])

    # Apaga se for o dono do comentário OU o dono da quadra
    if @comment.user == current_user || @quadra.user == current_user
      @comment.destroy
      redirect_back fallback_location: home_index_path, notice: "Avaliação apagada."
    else
      redirect_back fallback_location: home_index_path, alert: "Você não tem permissão."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:nota, :texto)
  end
end
