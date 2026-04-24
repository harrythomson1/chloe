class UserMedicationsController < ApplicationController
  before_action :authenticate_user!

  def create
    medication = Medication.find(params[:medication_id])
    current_user.medications << medication
    @user_medication = medication

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to medications_path }
    end
  end
end
