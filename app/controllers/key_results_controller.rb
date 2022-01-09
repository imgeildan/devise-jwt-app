class KeyResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.key_results
  end

  def create
    goal               = current_user.goals.find(params[:goal_id])
    key_result         = goal.key_results.new(key_result_params)
    key_result.user_id = current_user.id

    if key_result.save
    	render json: key_result, status: :created
    else
    	render json: key_result.errors, status: :unprocessable_entity
    end
  end

  private

  def key_result_params
  	params.require(:key_result).permit(:title, :status, :goal_id)
  end
end