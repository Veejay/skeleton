require_relative './column'
class SubRow
  attr_accessor :columns, :metadata, :widgets
  def initialize(data)
    row = data.delete('subrow')
    @columns = row.map do |column|
      Column.new column
    end
    @metadata = data
  end

  def widgets
    @widgets ||= @columns.reduce([]) do |widgets, column|
      widgets += column.widgets
      widgets
    end
  end

  def to_hash
    {
      "subrow" => @columns.map(&:to_hash)
    }.merge(@metadata)
  end
end
