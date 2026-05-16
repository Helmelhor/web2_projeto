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
      PublisherService.publish({ evento: "nova_quadra", quadra_id: @quadra.id })
      redirect_back fallback_location: home_index_path, notice: "Quadra postada com sucesso!"
    else
      render :new
    end
  end

  def edit
    # Busca a quadra específica que o usuário quer editar
    @quadra = Quadra.find(params[:id])

    # Segurança básica: Só deixa editar se o usuário logado for o dono da quadra
    unless @quadra.user == current_user
      redirect_to blog_path, alert: "Você não tem permissão para editar esta quadra."
    end
  end

  def update
    @quadra = Quadra.find(params[:id])

    # Atualiza os dados no banco
    if @quadra.update(quadra_params)
      redirect_to blog_path, notice: "Quadra atualizada com sucesso!"
    else
      # Se der erro (ex: deixou o nome em branco), recarrega a tela de edição
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quadra = Quadra.find(params[:id])
    @quadra.destroy
    redirect_back fallback_location: home_index_path, notice: "Quadra removida com sucesso."
  end

  private

  def quadra_params
    params.require(:quadra).permit(:nome, :endereco, :cidade, :descricao, :tipo_piso, :tem_iluminacao, :foto)
  end
end
