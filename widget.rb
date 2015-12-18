class Widget
  attr_accessor :id
  def initialize(widget)
    @id = widget['id']
    @metadata = widget
  end

  def to_hash
    @metadata.stringify_keys
  end
end
