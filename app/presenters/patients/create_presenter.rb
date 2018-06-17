module Patients
    
    class CreatePresenter
      
        def conditions
           Condition.all.map{ |c| [c.name,c.id]}
        end
    end
end