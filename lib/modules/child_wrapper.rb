module ChildWrapper
  def self.wrap child
    klass = child.has_key?('subrow') ? SubSection : Widget
    klass.new child
  end
end
