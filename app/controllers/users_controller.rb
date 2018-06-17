class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!
  
  #viewing all docs
  def index
    @users = User.all.order('created_at DESC')
    
  end
  
  #viewing specific user info
  def show
    @user = User.find(params[:id])
    #@user.clinic_id = params[:clinic_id]
    @clinic = @user.clinic_id
    @user_patients = @user.patients.order(sort_column + " "+ sort_direction)
    @presenter = Users::ShowPresenter.new
   
  end
  
  #methods used for sorting
  private
  
    def sort_column
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "sname"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "fname"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "dob"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "address"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "phoneno"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "infection"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "injury"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "observations"
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "condition_id"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
end
