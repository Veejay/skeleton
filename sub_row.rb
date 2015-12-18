require_relative './column'
class SubRow
  def initialize(data)
    row = data.delete('subrow')
    @columns = row.map do |column|
      Column.new column
    end
    @metadata = data
  end

  def widgets
    @widgets ||= @columns.flat_map &:widgets
  end

  def to_hash
    {
      "subrow" => @columns.map(&:to_hash)
    }.merge(@metadata)
  end
end
