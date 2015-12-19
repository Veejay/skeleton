require_relative './column'
class Section
  include Container
  def initialize(section)
    @metadata = section
    @columns = @metadata.fetch('row').map do |column|
      Column.new column
    end
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
