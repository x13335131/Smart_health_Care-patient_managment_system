module Patients
    
    class EditPresenter
      
        def conditions
           Condition.all.map{ |c| [c.name,c.id]}
        end
    end
end