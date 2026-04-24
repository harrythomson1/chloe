class MedicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_medications = current_user.medications

    return if params[:query].blank?

    @search_results = Medication.where('name ILIKE ?', "%#{params[:query]}%")
  end
end
