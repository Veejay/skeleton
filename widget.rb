class Widget
  attr_accessor :id
  def initialize(widget)
    @id = widget['id']
  end
end
