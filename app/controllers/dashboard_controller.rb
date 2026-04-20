class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @conditions_count = current_user.conditions.count
    @medications_count = current_user.medications.count
  end
end
