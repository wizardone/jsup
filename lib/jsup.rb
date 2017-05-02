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
    attributes[method.to_s] = args.first
  end
end
