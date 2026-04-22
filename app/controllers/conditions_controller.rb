class ConditionsController < ApplicationController
  before_action :authenticate_user!

  def search
    @conditions = Condition.where('name ILIKE ?', "%#{params[:query]}%")
  end
end
