require_relative './widget'
require_relative './sub_section'

using HashRefinements

class Row

  extend Forwardable

  def_delegator :@content, :widgets

  def initialize child
    klass = child.has_key?('subrow') ? SubSection : Widget
    @content = klass.new child
  end

  def to_hash
    @content.to_hash.stringify_keys
  end

end
