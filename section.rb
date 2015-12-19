require_relative './column'
class Section
  #attr_reader :columns
  def initialize(section)
    columns = section.fetch('row')
    @columns = columns.map do |column|
      Column.new column
    end
    @metadata = section.except('row')
  end

  def widgets
    @widgets ||= @columns.flat_map &:widgets
  end

  def to_hash
    {
      "row" => @columns.map(&:to_hash)
    }.merge(@metadata)
  end

end
