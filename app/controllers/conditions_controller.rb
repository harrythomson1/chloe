class ConditionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_conditions = current_user.conditions

    return if params[:query].blank?

    @search_results = Condition.where('name ILIKE ?', "%#{params[:query]}%")
  end
end
