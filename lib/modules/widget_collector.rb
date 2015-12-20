module WidgetCollector
  attr_writer :children
  def widgets
    @widgets ||= @children.flat_map &:widgets
  end
end
