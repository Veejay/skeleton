require_relative './column'
require_relative '../modules/widget_collector'
require_relative '../modules/refinements/hash_refinements'

using HashRefinements

class Section

  include WidgetCollector

  def initialize section
    @children = section.fetch('row').map do |column|
      Column.new column
    end
    @metadata = section
  end

  def widgets
    @widgets ||= @children.flat_map &:widgets
  end

  def to_hash
    {
      "row" => @children.map(&:to_hash)
    }.merge(@metadata)
  end

end
