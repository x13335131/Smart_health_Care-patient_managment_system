class PdfDocument < Prawn::Document
   
    def initialize(patient)
        super(top_margin: 70)
        @patient = patient
        @title = "referral letter"
        header
        hospital_address
        date
        addressedTo
        patient_name
        content
        closing
    end
    
    def header
        raise 'Called abstract method: header'
    end
    
    def  hospital_address
        raise 'Called abstract method: hospital_address'
    end
     
    def date
        move_down 10
        raise 'Called abstract method: date'
    end
    
    def addressedTo
        move_down 20
        raise 'Called abstract method: addressedTo'
    end
    
    def patient_name
        move_down 20
        raise 'Called abstract method: patient_name'
    end
    
    def content
        raise 'Called abstract method: content'
    end
    
    def closing
        move_down 20
        raise 'Called abstract method: closing'
    end
end
class AdultReferralPdf < PdfDocument
   
    
    def header
        text "Glasnevin Family Practice, \n 11 Finglas Road, Harts Corner, \n Glasnevin, Dublin", :align => :right
    end
    
    def  hospital_address
         move_down 20
         text "Matter private, \n Eccles Street, Dublin 7"
    end
     
    def date
        move_down 10
        require 'date'
        text Date.today.to_s
    end
    
    def addressedTo
        move_down 20
        text "Dear sir/madam,"
    end
    def patient_name
        move_down 20
        text "I am writing to you on behalf of my patient #{@patient.fname} #{@patient.sname}, "
    end
    
    def content
        text "who has a #{@patient.injury} and needs proper medical attention. " 
    end
    
    def closing
        move_down 20
        text "kind regards, \n DR. #{@patient.user.fname} #{@patient.user.lname}"
    end
end
class ChildrensReferralPdf < PdfDocument
   
   
    def header
        text "St Marys Family Practice, \n 11 Finglas Road, Harts Corner, \n Glasnevin, Dublin", :align => :right
    end
    
    def  hospital_address
         move_down 20
         text "Temple street Childrens Hospital, \n Temple Street, Dublin"
    end
     
    def date
        move_down 10
        require 'date'
        text Date.today.to_s
    end
    
    def addressedTo
        move_down 20
        text "Dear sir/madam,"
    end
    def patient_name
        move_down 20
        text "I am writing to you on behalf of my patient #{@patient.fname} #{@patient.sname}, "
    end
    
    def content
        text "who has a #{@patient.injury} and needs proper medical attention. " 
    end
    
    def closing
        move_down 20
        text "kind regards, \n DR. #{@patient.user.fname} #{@patient.user.lname}"
    end
end

class ReceiptPdf < PdfDocument
   
   
    def header
        text "THIS IS YOUR RECEIPT", :align => :center
        text "\n St Marys Family Practice, \n 11 Finglas Road, Harts Corner, \n Glasnevin, Dublin", :align => :right
    end
    def  hospital_address
         text ""
    end
     
    def date
        move_down 30
        require 'date'
        text "Date: #{Date.today}"
    end
    
    def addressedTo
        move_down 20
        text "Patient: #{@patient.fname} #{@patient.sname}"
    end
    
    def patient_name
        text ""
    end
    def content
        text "Description: #{@patient.observations} \n " 
        
        move_down 40
        
        if @patient.dob > Date.new(2000,1,1)
            text "Total charge: €30.00"
        else 
            text "Total charge: €50.00"
        end
         move_down 10
         text "Your next appointment is : #{@patient.next_apt}"
    end
    
    def closing
        move_down 20
        text "Doctor signture,"
        move_down 10
        text "\n _______________, \n "
        text "DR. #{@patient.user.fname} #{@patient.user.lname}"
    end
end