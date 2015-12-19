require_relative './column'
class SubSection
  def initialize(data)
    row = data.fetch('subrow')
    @columns = row.map do |column|
      Column.new column
    end
    @metadata = data.except('subrow')
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