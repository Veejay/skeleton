require_relative './row'
require_relative '../modules/widget_collector'
require_relative '../modules/refinements/hash_refinements'

using HashRefinements

class Column

  include WidgetCollector

  def initialize(column)
    @children = column.fetch('items').map do |row|
      Row.new row
    end
    @metadata = column.except('items')
  end

  def to_hash
    {
      "items" => @children.map(&:to_hash)
    }.merge(@metadata)
  end

end
