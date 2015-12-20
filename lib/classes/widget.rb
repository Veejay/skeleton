require_relative '../modules/refinements/hash_refinements'

using HashRefinements

class Widget

  attr_accessor :id

  def initialize(widget)
    @id = widget.fetch('id')
    @metadata = widget.except('id')
  end

  def to_hash
    @metadata.merge({id: @id})
  end

  def widgets
    [self]
  end

end
