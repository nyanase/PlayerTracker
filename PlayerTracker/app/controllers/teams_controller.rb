class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.create(team_params)

    if @team
      respond_to do |format|
        if @team.save
          @player = Player.create(coach: false)
          @team.players << @player
          @user = current_user
          @user.players << @player

          format.html { redirect_to root_path }
          format.json { render :show, status: :created, location: root_path }
        else
          puts "ERRORS: "
          puts @team.errors.first
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

end
