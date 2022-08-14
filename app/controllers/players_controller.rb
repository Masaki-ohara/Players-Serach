class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]
  before_action :set_q, only: [:index, :search]

  def search
    @players = Players.all
    if params[:search].present?
  end
  
  # GET /players or /players.json
  def index
    @q = Player.ransack(params[:q])
    @players = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @results = @q.result
  end

  private
  def set_q
    @q = User.ransack(params[:q])
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.fetch(:player, {})
    end
end
