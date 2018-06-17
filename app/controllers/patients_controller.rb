class PatientsController < ApplicationController
 # protect_from_forgery with: :null_session
 #before_action :authenticate_user!, :except => [:report]
  before_action :set_patient, only: [:show,:edit, :update, :destroy]
  before_action :authenticate_user!
  
  require 'date'

  # GET /patients
  # GET /patients.json
  #viewing all patients in db
  def index

    if params.has_key?(:condition)
      @condition_id = Condition.find_by(name: params[:condition]).id 
       @patients = Patient.where(:condition_id => @condition_id).order("created_at DESC")
    elsif params[:search]
      @patients = Patient.search(params[:search]).order("created_at DESC")
    else
     @patients = Patient.all.order('created_at DESC')
    end
  end
  
  #getting monthly/weekly and daily reports as well as weekly appointments
  def report
    @input = params[:input].to_s 
     puts " INPUT : #{@input}"
     
    if params[:input] == "daily"
       @patients=Patient.where(:visited => Date.today)

    end
    if @input== "weekly"
       @patients=Patient.where(:visited => Date.today.beginning_of_week..Date.today.at_end_of_week)
    end
    if @input =="monthly"
       @patients=Patient.where(:visited => Date.today.beginning_of_month..Date.today.at_end_of_month)
    end
    if @input =="weeklyapt"
       @patients=Patient.where(:next_apt => Date.today.beginning_of_week..Date.today.at_end_of_week)
    end
  end
  
  # GET /patients/1 
  #showing a given patients info
  def show
    
    @type = params[:type]
    require 'pdf_docs'
    @input = @patient.condition.name
    @result = Referral.runcheck(@input.to_s)
    
    #PDF GENERATION CODE
    respond_to do |format|
      format.html
      format.pdf do
        if @type == 'refer'
         if @patient.dob < Date.new(2000,1,1)
             pdf = AdultReferralPdf.new(@patient)
          else 
           pdf = ChildrensReferralPdf.new(@patient)
         end
              send_data pdf.render, filename: "#{@patient.fname}_#{@patient.sname}_referral.pdf", type: "application/pdf", disposition: "attachment"
        end
        
       if @type == 'receipt'
        pdf = ReceiptPdf.new(@patient)
          send_data pdf.render, filename: "#{@patient.fname}_#{@patient.sname}_receipt.pdf", type: "application/pdf", disposition: "attachment"
       
       end
      end
    end
  end

  # GET /patients/new
  def new
   @presenter = Patients::NewPresenter.new
  end

  # GET /patients/1/edit
  def edit
    @presenter = Patients::EditPresenter.new
  end

  # POST /patients
  # POST /patients.json
  def create
    @presenter = Patients::CreatePresenter.new
    @patient = current_user.patients.build(patient_params)
    @patient.condition_id = params[:condition_id]
   # @conditions = Condition.all.map{ |c| [c.name,c.id]}
    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    @patient.condition_id = params[:condition_id]
    
    respond_to do |format|
      if @patient.update(patient_params)
        
          # creating observer
          observer_a = Observer.new
          
          # observer_b = Observer.new
          subject = Subject.new(@patient.fname,@patient.sname)
            
          # giving subject a name
          # subject.fname = @patient.fname
          # subject.sname = @patient.sname
            
          # attaching observer to subject
          subject.attach_observer(observer_a)
        
          # changing state of subject
          # subject.fname = @patient.fname
          # subject.sname = @patient.sname
              
          # notifying the observers that change has occured.
          subject.notify_observers(observer_a)
          @resp = observer_a.response
      
          format.html { redirect_to @patient, notice: " #{@resp}" }
          format.json { render :show, status: :ok, location: @patient }
              
          
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
        
      end
    end
         
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:fname, :sname, :dob, :address, :phone_no, :infection, :injury, :observations, :visited, :next_apt, :condition_id)
    end
  
end
