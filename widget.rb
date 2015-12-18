class Widget
  def initialize(widget)
    @id = widget['id']
    @metadata = widget
  end

  def to_hash
    @metadata.stringify_keys
  end
end
