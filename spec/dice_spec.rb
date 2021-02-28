# frozen_string_literal: true

require "faker"
require_relative "../app/game"

RSpec.describe Dice do
  subject { described_class.instance }

  context "#initialize" do
    it "should initialize dice with dice sides" do
      expect(subject.instance_variables).to include(:@sides)
    end
  end

  context "#roll" do
    it "should return random dice score in betweem 1 to 6" do
      expect(subject.roll).to be_between(1, 6)
    end
  end
end
