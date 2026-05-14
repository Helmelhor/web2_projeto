class CommentsController < ApplicationController
  def create
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back fallback_location: root_path, notice: "Comentário enviado!"
    else
      redirect_back fallback_location: root_path, alert: "Erro ao comentar."
    end
  end


  def update
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.find(params[:id])

    if @comment.user == current_user && @comment.update(comment_params)
      redirect_back fallback_location: root_path, notice: "Comentário atualizado."
    else
      redirect_back fallback_location: root_path, alert: "Erro ao editar."
    end
  end

  def destroy
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.find(params[:id])

    if @comment.user == current_user || @quadra.user == current_user
      @comment.destroy
      redirect_back fallback_location: root_path, notice: "Comentário apagado."
    else
      redirect_back fallback_location: root_path, alert: "Você não tem permissão."
    end
  end

  private

  def comment_params
    # Liberamos o parent_id para aceitar respostas
    params.require(:comment).permit(:nota, :texto, :parent_id)
  end
end
