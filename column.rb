require_relative './row'
class Column
  attr_accessor :rows, :metadata, :widgets
  def initialize(column)
    rows = column.delete('items')
    @rows = rows.map do |row|
      Row.new row
    end
    @metadata = column
  end

  def widgets
    @widgets ||= @rows.reduce([]) do |widgets, row|
      widgets += row.widgets
      widgets
    end
  end
end
