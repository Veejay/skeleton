module WidgetCollector
  def widgets
    @widgets ||= @children.flat_map &:widgets
  end
end
