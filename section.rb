require_relative './column'
class Section
  attr_accessor :columns, :metadata, :widgets
  def initialize(section)
    columns = section.delete('row')
    @columns = columns.map do |column|
      Column.new column
    end
    @metadata = section
  end

  def widgets
    @widgets ||= columns.flat_map &:widgets
  end

  def to_hash
    {
      "row" => @columns.map(&:to_hash)
    }.merge(@metadata)
  end

end
