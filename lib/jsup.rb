require 'version'

class Jsup

  attr_reader :attributes
  def self.produce
    yield self
  end

  def ojify
    Oj.dump
  end

  def new
    @attributes = Hash.new
  end

  private

  def method_missing(method, *args)
    attributes[method] = args
  end
end
