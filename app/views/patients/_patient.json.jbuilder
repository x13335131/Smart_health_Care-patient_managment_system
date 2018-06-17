json.extract! patient, :id, :fname, :sname, :dob, :address, :phone_no, :infection, :injury, :observations, :created_at, :updated_at
json.url patient_url(patient, format: :json)
