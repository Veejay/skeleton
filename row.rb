require_relative './widget'
require_relative './sub_row'
require 'pry'
class Row
  def initialize(row)
    if row.has_key?('subrow')
      @type = "subrow"
      @content = SubRow.new(row)
    else
      @type = "widget"
      @content = Widget.new(row)
    end
  end

  def sub_row?
    return @type == "subrow"
  end

  def widget?
    return @type == "widget"
  end

  def to_hash
    @content.to_hash.stringify_keys
  end

  def widgets
    @widgets ||= if widget?
      [@content]
    else
      @content.widgets
    end
  end
end
