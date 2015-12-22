require_relative '../modules/refinements/hash_refinements'

using HashRefinements

class Collection
  COLLECTIONS = {
    section: {
      fetch: 'row',
      as: 'column'
    },
    column: {
      fetch: 'items',
      as: 'row'
    },
    subsection: {
      fetch: 'subrow',
      as: 'column'
    }
  }

  def initialize data
    @children = data.fetch(collection_info.fetch(:fetch)).map do |child|
      Object.const_get(collection_info.fetch(:as).capitalize).new child
    end
    @metadata = data.except(collection_info.fetch(:as))
  end

  def widgets
    @children.flat_map(&:widgets)
  end

  def to_hash
    {
      collection_info.fetch(:fetch) => @children.map(&:to_hash)
    }.merge(@metadata)
  end

  private

  def collection_info
    @collection_info ||= COLLECTIONS.fetch(self.class.to_s.downcase.to_sym)
  end
end
