require_relative './widget'
require_relative './sub_section'
require_relative '../modules/widget_collector'
require_relative '../modules/child_wrapper'
require_relative '../modules/refinements/hash_refinements'

using HashRefinements

class Row

  include WidgetCollector
  include ChildWrapper

  def initialize row
    @content = ChildWrapper.wrap(row)
  end

  def to_hash
    @content.to_hash.stringify_keys
  end

end
