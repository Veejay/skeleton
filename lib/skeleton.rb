require 'rubygems'
require 'bundler'
require 'pry'
require 'json'
require 'newrelic_rpm'
require_relative './section'

# Provides a wrapper interface to the widgets
# There must be a way to just forward to the collection



class WidgetCollection
  def initialize collection
    @collection = collection
  end

  def find_by(id:)
    @collection.detect do |widget|
      widget.id == id
    end
  end

  def pluck attribute
    @collection.map &attribute
  end

end

class SkeletonFileExtractor
  attr_reader :skeleton

  def initialize path
    @skeleton = JSON.parse File.read path
  end

  # Extracts a give property and saves the other properties of the Object
  # for later use
  def extract key
    self.tap do
      @extracted, @metadata = @skeleton['children'][0].fetch! key
    end
  end

  # Encapsulates raw data
  def wrap klass
    wrapped = @extracted.map do |e|
       Object.const_get(klass.to_s.capitalize).new(e)
    end
    [wrapped, @metadata]
  end

end

class Skeleton
  attr_reader :extractor
  def initialize path
    @extractor = SkeletonFileExtractor.new(path)
    @sections, @metadata = @extractor.extract('bgSection').wrap(:section)
  end

  # FIXME: This method is used by all entities of the library who
  # are actually collection of other entities
  # A skeleton is a collection of sections
  # A section is a collection of columns
  # A column is a collection of rows
  # A row is a collection of row items which can be either a Widget or a SubSection
  # Finally, a SubSection is basically a level-2 section inside a column
  def widgets
    @widgets ||= WidgetCollection.new @sections.flat_map &:widgets
  end

  def replace(widget:, by: )
    widgets.find_by(id: widget).id = by
  end

  # The most important method, it must recreate a pristine JSON document
  # representing the skeleton
  def to_hash
    {
      "children" => [
        {
          "bgSection" => @sections.map(&:to_hash)
        }.merge(@metadata)
      ]
    }
  end

  def pristine?
    @extractor.skeleton.eql? to_hash
  end

  def deleted_widget_ids(widget_ids)
    widgets.pluck(:id) - widget_ids
  end

end

class Hash
  def stringify_keys
    reduce(Hash.new) do |hash, (key, value)|
      hash[key.to_s] = value
      hash
    end
  end

  def except!(*keys)
    keys.each do |key|
      delete(key)
    end
    self
  end

  def except(*keys)
    dup.except! *keys
  end

  def fetch! key
    [fetch(key), except(key)]
  end
end