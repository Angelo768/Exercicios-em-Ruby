class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  # before_action :authenticate_user!, only: [:create, :destroy]

  # GET /tasks
  # def index
  #   @tasks = Task.all
  #
  #   render json: @tasks
  # end

  # GET /tasks/1
  def show
    render json: @task, :include => {:list => {:only => [:board_id]}}
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    # Checa se a board foi trocada
    if @task.list.board_change(task_params[:list_id])
      render :json => {errors: "Não é possível mover uma atividade para uma board nova"},
      status: :method_not_allowed
      return
    end

    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :list_id)
    end
end
