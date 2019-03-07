class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]
  # before_action :authenticate_user!, only: [:create, :destroy]

  # GET /lists
  # def index
  #   @lists = List.all
  #
  #   render json: @lists, :except => [:created_at, :updated_at],
  #                        :include => {:board => {:except => [:created_at, :updated_at]}},
  #                        :include => {:tasks => {:except => [:created_at, :updated_at]}},
  #                        root: true
  # end

  # GET /lists/1
  def show
    render json: @list, :except => [:created_at, :updated_at],
                        :include => {:tasks => {:except => [:created_at, :updated_at]}},
                        root: true
  end

  # POST boards/1/lists
  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render :json => @list, :include => :tasks
    else
      render :json => @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    #Se antes de uma lista ser destruida for passado um list_id, todas as atividades passarão para a nova lists
    #Caso contràrio as atividades serão destruidas junto da lista
    if params.has_key?(:list_id)
      identify = params.fetch(:list_id)
      select_list = List.find(identify)

      if @list.board_change(id)
        render :json => {errors: "Não é possível mover atividades para fora de seu quadro!"}
        return
      end

      @list.tasks.each do |task|
        task.list = select_list
        task.save
      end

      # Limpando a lista antes de deletar
      @list.tasks = []
      @list.save

    end

    @list.destroy
    render :json => {message: "Lista destruída com sucesso"}

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(
        :name, :board_id, tasks_attributes: [:name, :description, :list_id]
      )
    end
end
