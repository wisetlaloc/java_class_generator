# frozen_string_literal: true

require_relative 'writer'

args = ARGV.dup
class_name = args.shift
properties = args.map do |arg|
  type, name = arg.split(':')
  { type: type, name: name }
end

Writer.new(class_name, properties).render
