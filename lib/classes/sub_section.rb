require_relative './column'
require_relative '../modules/widget_collector'
require_relative '../modules/refinements/hash_refinements'

using HashRefinements

class SubSection

  include WidgetCollector

  def initialize data
    @children = data.fetch('subrow').map do |column|
      Column.new column
    end
    @metadata = data.except('subrow')
  end

  def to_hash
    {
      "subrow" => @children.map(&:to_hash)
    }.merge(@metadata)
  end

end
