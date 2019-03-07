class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :update, :destroy]
  # Descomentando a linha abaixo vc pode habilitar a função de autenticar um usuário para
  # criar e destruir um arquivo se assim desejar, o mesmo vale para os outros controllers
  # before_action :authenticate_user!, only: [:create, :destroy]

  # GET /boards
  def index
    @boards = Board.all

    render json: @boards, :except => [:created_at, :updated_at]
  end

  # GET /boards/1
  def show
    render json: @board,
        :include => {:lists => {:include =>
                    {:tasks => {:except => [:created_at, :updated_at]}},
                     :except => [:created_at, :updated_at]
                   }
                 }, root: true
  end

  # POST /boards
  def create
    @board = Board.new(board_params)

    if @board.save
      render json: @board, status: :created, location: boards_url(@board)
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /boards/1
  def update
    #board = Board.find(board_params[:id])

    if @board.update(board_params)
      render json: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def board_params
      params.require(:board).permit(:name,
        lists_attributes: [:name, :id, :board_id]
      )
    end
end
