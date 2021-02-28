# frozen_string_literal: true

require "highline"
require "singleton"
require_relative "./constant"
require_relative "../app/game"

# Game command line interface
class GameCli
  include Singleton

  attr_reader :cli

  def initialize
    @cli = HighLine.new
  end

  def introduction
    cli.say(Constant::GAME_BANNER)
    cli.say(Constant::GAME_INTRODUCTION)
  end

  def start_game
    cli.choose do |menu|
      menu.prompt = "Select an option"
      menu.choice("Let's Play") { lets_play }
      menu.choice("Rule Book") { prompt_rule_book }
      menu.choice("Exit Game") { exit_game }
      menu.default = "Let's Play"
    end
  end

  def prompt_player_turn(player_name)
    cli.ask("\n#{player_name} its your turn (press 'r' to roll the dice)") { |option| option.validate = /r/ }
  end

  def prompt_skip_player(player_name)
    cli.say("\n => Oops! #{player_name}, you can throw dice in next turn, your turn is skip")
  end

  def print_dice_result(player_name, score)
    return cli.say("\n => Nice!, #{player_name} got 6 points, Roll again ...") if score.eql?(6)

    cli.say("\n => #{player_name} got #{score} points")
  end

  def print_leader_board(players)
    players.sort_by!(&:rank)
    puts "\n!!!====== Game Leaderboard ======!!!\n\n"
    headers = "Rank | Player name | Score"
    leader_board = players.map(&:dashboad_summary).prepend(headers)
    puts cli.list(leader_board, :columns_across, 1)
  end

  def congratulate_player(player_name, rank)
    cli.say("\nCongratulations #{player_name} !!! You secured #{rank} rank")
  end

  private

  def lets_play
    number_of_players = cli.ask("Enter total number of players:", Integer) do |player_count|
      player_count.in = Constant::MIN_PLAYERS..Constant::MAX_PLAYERS
    end
    total_points = cli.ask("Enter total score to accumulate each player:", Integer) { |score| score.above = 1 }
    Game.new(number_of_players, total_points).start
    cli.say("\nGame over... play again !!!\n\n")
    start_game
  end

  def prompt_rule_book
    cli.say(Constant::GAME_RULES)
    start_game
  end

  def exit_game
    cli.say("\nOk, see you next time... bye!")
    exit 0
  end
end
