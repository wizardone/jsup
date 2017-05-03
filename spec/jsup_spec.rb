require 'spec_helper'
require 'byebug'

RSpec.describe Jsup do

  it 'has a version number' do
    expect(Jsup::VERSION).not_to be nil
  end

  describe '.produce' do
    let!(:klass) do
      Class.new do
        def city
          'Sofia'
        end

        def area
          'Area 51'
        end
      end
    end

    it 'produces a simple json' do
      expect(
        Jsup.produce do |j|
          j.first 'Stefan'
          j.email 'stefan@stefan.com'
        end
      ).to eq({ 'first': 'Stefan', 'email': 'stefan@stefan.com' }.to_json)
    end

    it 'produces extracted json content with single attribute' do
      address = klass.new

      expect(
        Jsup.produce do |j|
          j.name 'Stefan'
          j.fetch(address, :city)
        end
      ).to eq({ 'name': 'Stefan', 'city': 'Sofia' }.to_json)
    end

    it 'produces extracted json content with multiple attributes' do
      address = klass.new

      expect(
        Jsup.produce do |j|
          j.name 'Stefan'
          j.fetch(address, :city, :area)
        end
      ).to eq({ 'name': 'Stefan', 'city': 'Sofia', 'area': 'Area 51' }.to_json)
    end
  end
end
