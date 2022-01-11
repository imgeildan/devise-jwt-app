class GoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { data: current_user.goals, status: 200, message: 'success'} 
  end

  def create
    goal = current_user.goals.new(goal_params)

    if goal.save
    	render json: goal, status: :created
    else
    	render json: goal.errors, status: :unprocessable_entity
    end
  end

  def show
    goal = current_user.goals.find(params[:id])
    
    render json: { title:      goal.title, 
                   start_date: goal.start_date, 
                   end_date:   goal.end_date,
                   progress:   "#{goal.calculate_progress} %",
                   status: 200 }
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :start_date, :end_date)
  end
end