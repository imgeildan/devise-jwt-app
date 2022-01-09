class GoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.goals
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
    goal        = current_user.goals.find(params[:id])
    key_results = goal.key_results
    percentage  = 100 * key_results.completed.count / key_results.count 
    progress    = key_results.count.zero? ? 0 : percentage
    
    render json: { title:      goal.title, 
                   start_date: goal.start_date, 
                   end_date:   goal.end_date,
                   progress:   "#{progress} %" }
  end

  private

  def goal_params
  	params.require(:goal).permit(:title, :start_date, :end_date)
  end
end