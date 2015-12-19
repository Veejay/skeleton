require_relative './widget'
require_relative './sub_section'
require 'pry'
class Row
  def initialize(row)
    #@content = ChildExtractor.new(row).content
    @content = if row.has_key?('subrow')
      SubSection.new(row)
    else
      Widget.new(row)
    end
  end

  def to_hash
    @content.to_hash.stringify_keys
  end

  def widgets
    @widgets ||= @content.widgets
  end

  class ChildExtractor
    attr_reader :content
    def initialize child
      klass = child.has_key?('subrow') ? SubSection : Widget
      @content = klass.new child
    end
  end
end
