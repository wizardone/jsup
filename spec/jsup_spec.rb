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

    it 'produces extracted json content' do
      address = klass.new

      expect(
        Jsup.produce do |j|
          j.name 'Stefan'
          j.fetch(address, :city)
        end
      ).to eq({ 'name': 'Stefan', 'city': 'Sofia' }.to_json)
    end
  end
end
