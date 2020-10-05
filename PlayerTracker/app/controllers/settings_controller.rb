class SettingsController < ApplicationController
  def show
    @team = Team.find(params[:team_id])
  end
end
