module UsersHelper
    def full_name
        @user.fname + " " + @user.lname
    end
    
end
