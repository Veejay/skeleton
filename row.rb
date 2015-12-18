require_relative './widget'
require_relative './sub_row'
require 'pry'
class Row
  attr_accessor :type, :content, :widgets
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

  def widgets
    @widgets ||= if widget?
      [self.content]
    else
      self.content.widgets
    end
  end
end
