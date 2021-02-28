# frozen_string_literal: true

# To handle Player identity and it's dashboard summary
class Player
  attr_reader :name, :total_score, :rank, :last_score

  def initialize(name)
    @name = name
    @rank = 0
    @total_score = 0
    @is_winner = false
    @skip_turn = false
    @last_score = 0
  end

  def skip_turn?
    @skip_turn
  end

  def winner?
    @is_winner
  end

  def mark_skip!
    @skip_turn = true
  end

  def unmark_skip!
    @skip_turn = false
  end

  def mark_winner!
    @is_winner = true
  end

  def dashboad_summary
    "#{@rank.zero? ? "-" : @rank} | #{@name} | #{@total_score}"
  end

  %w[total_score rank last_score].each do |attribute|
    define_method "update_#{attribute}" do |value|
      instance_variable_set("@#{attribute}", value)
    end
  end
end
