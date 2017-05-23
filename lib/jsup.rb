require 'version'
require 'oj'

class Jsup

  attr_reader :attributes

  Oj.default_options = {
    allow_blank: true,
    use_as_json: true
  }

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

  def method_missing(method, *args, &block)
    if args.length == 1
      add_attribute(method.to_s, args.first)
    elsif args.length > 1
      object = args.first
      attrs = args[1..args.length]
      attrs.each do |attr|
        add_attribute(attr.to_s, object.public_send(attr)) if object.respond_to?(attr)
      end
    elsif block_given?
      nested_attributes = Jsup.new.tap { |json| yield json }.attributes
      add_attribute(method.to_s, nested_attributes)
    end
  end

  def add_attribute(method, attribute)
    attributes[method] = attribute
  end
end
