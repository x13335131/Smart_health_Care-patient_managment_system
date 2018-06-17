class Observer
  def update(changed_subject)
      @name = changed_subject
      @response="#{@name.fname} #{@name.sname}'s data has been changed/updated"
  end
  attr_reader :response
end