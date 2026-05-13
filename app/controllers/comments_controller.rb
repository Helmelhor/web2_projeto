class CommentsController < ApplicationController
  def create
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.build(comment_params)
    @comment.user_id = current_user.id # Puxando do seu sistema de login

    @comment.save
    redirect_to quadras_path, notice: "Avaliação adicionada!"
  end

  def destroy
    @quadra = Quadra.find(params[:quadra_id])
    @comment = @quadra.comments.find(params[:id])
    @comment.destroy
    redirect_to quadras_path, notice: "Avaliação apagada."
  end

  private
  def comment_params
    params.require(:comment).permit(:nota, :texto, :user_id)
  end
end
