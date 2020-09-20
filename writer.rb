# frozen_string_literal: true

require 'active_support/all'

class Writer
  def initialize(class_name, properties)
    @class_name = class_name
    @properties = properties
  end

  def render
    lines.each do |line|
      puts line
    end
  end

  def lines
    render_class do
      [
        render_properties,
        '',
        render_constructor do
          set_properties
        end
      ]
    end
  end

  def render_class
    ["class #{@class_name} {", yield.flatten.map { |line| line.indent(4) }, '}']
  end

  def render_properties
    @properties.map do |property|
      "public #{property[:type]} #{property[:name]};"
    end
  end

  def render_constructor
    properties_listed = @properties.map { |property| "#{property[:type]} #{property[:name]}" }.join(', ')
    ["public #{@class_name}(#{properties_listed}){",
     yield.map { |line| line.indent(4) },
     '}']
  end

  def set_properties
    @properties.map { |property| "this.#{property[:name]} = #{property[:name]};" }
  end
end
