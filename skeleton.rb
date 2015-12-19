require 'rubygems'
require 'bundler'
require 'pry'
require 'json'
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

class Skeleton
  def initialize path
    skeleton = JSON.parse File.read path
    data = skeleton['children'][0]
    sections = data.fetch('bgSection')
    @sections = sections.map do |section|
      Section.new(section)
    end
    @metadata = data.except('bgSection')
  end

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
    skeleton = JSON.parse File.read "foo.json"
    skeleton.eql? to_hash
  end

  def deleted_widget_ids(widget_ids)
    widgets.pluck(:id) - widget_ids
  end

end

class Hash
  def stringify_keys
    self.reduce(Hash.new) do |hash, (key, value)|
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
end

skeleton = Skeleton.new "foo.json"
puts "Skeleton is#{skeleton.pristine? ? "" : " not"} pristine"
