
class Patient < ActiveRecord::Base
     
    
    validates :phone_no, length: { is: 9 }
    belongs_to :user
    belongs_to :condition


  
    def self.search(search)
      search.upcase!
      where("fname || sname LIKE ?", "%#{search}%")
    end
    
   def fname=(value)
      write_attribute(:fname, value.upcase)
   end
    
    def sname=(value)
      write_attribute(:sname, value.upcase)
    end
    
    def address=(value)
      write_attribute(:address, value.upcase)
    end
    def infection=(value)
      write_attribute(:infection, value.upcase)
    end
    def injury=(value)
      write_attribute(:injury, value.upcase)
    end
    def observations=(value)
      write_attribute(:observations, value.upcase)
    end
end