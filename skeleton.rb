require 'rubygems'
require 'bundler'
require 'pry'
require 'json'
require_relative './section'

# Provides a wrapper interface to the widgets
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
  attr_accessor :sections
  attr_reader :metadata
  def initialize path
    skeleton = JSON.parse File.read path
    data = skeleton['children'][0]
    sections = data.delete('bgSection')
    @sections = sections.map do |section|
      Section.new(section)
    end
    @metadata = data
  end

  def widgets
    @widgets ||= WidgetCollection.new @sections.flat_map &:widgets
  end

  # The most important method, it must recreate a pristine JSON document
  # representing the skeleton
  def to_json
  end

  def deleted_widget_ids(widget_ids)
    widgets.pluck(:id) - widget_ids
  end

end

skeleton = Skeleton.new "foo.json"
binding.pry
