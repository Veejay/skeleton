require_relative './row'
class Column
  def initialize(column)
    rows = column.fetch('items')
    @rows = rows.map do |row|
      Row.new row
    end
    @metadata = column.except('items')
  end

  def widgets
    @widgets ||= @rows.flat_map &:widgets
  end

  def to_hash
    {
      "items" => @rows.map(&:to_hash)
    }.merge(@metadata)
  end
end
