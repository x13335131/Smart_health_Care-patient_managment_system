module Patients
    
    class NewPresenter
      
        def patient
            current_user.patients.build
        end
        
        def conditions
            Condition.all.map{ |c| [c.name,c.id]} 
        end
    end
end