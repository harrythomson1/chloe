class UserConditionsController < ApplicationController
  before_action :authenticate_user!

  def create
    condition = Condition.find(params[:condition_id])
    current_user.conditions << condition
    @user_condition = condition

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to conditions_path }
    end
  end
end
