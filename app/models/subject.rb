require 'observer'
class Subject
    attr_accessor :fname, :sname
    
  def initialize(fname, sname)
    @fname=fname
    @sname=sname
    @observers = []
  end
    
  def attach_observer(observer)
    @observers.push observer
  end

  def detach_observer(observer)
    @observers.remove observer
  end

  def notify_observers(observer)
    @observers.each { |observer| observer.update(self) }
  end
end