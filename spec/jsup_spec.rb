require "spec_helper"
require 'byebug'

RSpec.describe Jsup do
  it 'has a version number' do
    expect(Jsup::VERSION).not_to be nil
  end

  describe '.produce' do
    it 'produces a simple json' do
      expect(
        Jsup.produce do|j|
          j.first 'Stefan'
          j.email 'stefan@stefan.com'
        end
      ).to eq({ 'first': 'Stefan', 'email': 'stefan@stefan.com' }.to_json)
    end
  end
end
