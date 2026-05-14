class QuadrasController < ApplicationController
  def index
    @quadras = Quadra.all
  end

  def new
    @quadra = Quadra.new
  end

  def create
    @quadra = Quadra.new(quadra_params)
    @quadra.user = current_user

    if @quadra.save
      redirect_back fallback_location: home_index_path, notice: "Quadra postada com sucesso!"
    else
      render :new
    end
  end

  def edit
    @quadra = Quadra.find(params[:id])
  end

  def update
    @quadra = Quadra.find(params[:id])
    if @quadra.update(quadra_params)
      redirect_back fallback_location: home_index_path, notice: "Quadra atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @quadra = Quadra.find(params[:id])
    @quadra.destroy
    redirect_back fallback_location: home_index_path, notice: "Quadra removida com sucesso."
  end

  private

  def quadra_params
    params.require(:quadra).permit(:nome, :endereco, :cidade, :foto_url, :descricao, :tipo_piso, :tem_iluminacao)
  end
end
