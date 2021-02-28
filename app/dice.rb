# frozen_string_literal: true

require "singleton"
require_relative "./utils/math"

# Singletone class to get dice roll
class Dice
  include Singleton
  include Math

  def initialize
    @sides = Constant::DICE_SIDES
  end

  def roll
    random(@sides)
  end
end
