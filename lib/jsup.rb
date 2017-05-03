require 'version'
require 'oj'

class Jsup

  attr_reader :attributes

  def self.produce
    new.tap do |json|
      yield json
    end.ojify
  end

  def ojify
    Oj.dump(attributes)
  end

  def initialize
    @attributes = Hash.new
  end

  private

  def method_missing(method, *args)
    if args.length == 1
      attributes[method.to_s] = args.first
    elsif args.length > 1
      object = args.first
      attrs = args[1..args.length]
      attrs.each do |attr|
        attributes[attr.to_s] = object.public_send(attr) if object.respond_to?(attr)
      end
    end
  end

  def add_attribute(method, attribute)
    attributes[method] = attribute
  end
end
