class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create

    # if !Team.exists?(team_params)
    #   @team = Team.create(team_params)
    # else
    #   redirect_to new_team_path, notice: "Team already exists!"
      
    # end
    @team = Team.create(team_params)

    if @team
      respond_to do |format|
        if @team.save
          @player = Player.create(coach: false)
          @team.players << @player
          @user = current_user
          @user.players << @player

          format.html { redirect_to @team }
          format.json { render :show, status: :created, location: @team }
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
