class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :destroy]

  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)

    if @team
      respond_to do |format|
        if @team.save
          @player = Player.create(coach: true)
          @team.players << @player
          @user = current_user
          @user.players << @player

          format.html { redirect_to root_path }
          format.json { render :show, status: :created, location: root_path }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invite_new
    @team = Team.find(params[:team_id])
    @player = Player.new
  end

  def invite_create
    @team = Team.find(params[:team_id])
    respond_to do |format|
      if User.exists?(:email => params[:email])
        @user = User.find_by(:email => params[:email])
        if Player.exists?(team_id: @team.id, user_id: @user.id)
          flash[:error] = "Player is already on the team"
          format.html { render :invite_new}
          format.json { render json: @team.errors, status: :unprocessable_entity }
        else
          @player = Player.create(coach: false)
          @team.players << @player
          @user.players << @player

          format.html { redirect_to team_path(@team) }
          format.json { render :show, status: :created, location: team_path }
        end
      else
        flash[:error] = "User does not exist"
        format.html { render :invite_new}
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

end
