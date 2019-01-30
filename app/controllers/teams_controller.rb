class TeamsController < ApplicationController

    def index 
    end

    def show 
    end
    
    def new 
        @team = Team.new
        @event = Event.find(params[:event_id])
    end

    def create  
        team = Team.new(team_params)
        team.event_id = params[:event_id]
        teammate_email = team.teammate
        teammate_id = User.find_by(email: teammate_email)
    
        team.teammate = teammate_id.id
        
        if team.save 
            current_user.team_id = team.id
            teammate_id.team_id = team.id
            teammate_id.save
            current_user.save
            flash[:notice] = 'Team Created'
            redirect_to event_teams_path
        else 
            flash[:error] = "Team Failed to Save"
            redirect_to event_teams_path
        end
    end

    def update 
    end

    def destroy
    end

    private
    def team_params
        params.require(:team).permit(
            :group_name, 
            :bio,
            :teammate
        )
    end
end
