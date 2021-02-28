# frozen_string_literal: true

require_relative "./dice"
require_relative "./player"
require_relative "./utils/math"
require_relative "../lib/game_cli"

# Gaming area to start and handle players for every dice roll
class Game
  include Math

  attr_reader :game_cli, :players

  def initialize(number_of_players, total_max_score)
    @total_winners = 0
    @total_max_score = total_max_score
    @number_of_players = number_of_players
    @players = initialize_players
    @game_cli = GameCli.instance
  end

  def start
    shuffle_players
    loop do
      break if @total_winners.eql?(@number_of_players)

      live_players.each do |player|
        next player.unmark_skip! if player.skip_turn?

        play_turn(player)
      end
    end
  end

  private

  def initialize_players
    players = []
    (1..@number_of_players).each do |count|
      player_name = "Player #{count}"
      player = Player.new(player_name)
      players.push(player)
    end
    players
  end

  def shuffle_players
    @players.shuffle!
  end

  def live_players
    @players.reject(&:winner?)
  end

  def play_turn(player)
    current_score = roll_dice(player)
    return game_cli.prompt_skip_player(player.name) if player_skipable?(player, current_score)

    update_player_dashboard(player, current_score)
    game_cli.congratulate_player(player.name, player.rank) if player.winner?
    game_cli.print_leader_board(@players)
    play_turn(player) if roll_dice_again?(current_score, player)
  end

  def roll_dice(player)
    game_cli.prompt_player_turn(player.name)
    current_score = Dice.instance.roll
    game_cli.print_dice_result(player.name, current_score)
    current_score
  end

  def update_player_dashboard(player, current_score)
    player.update_total_score(player.total_score + current_score)
    player.mark_skip! if current_score.eql?(player.last_score)

    player.mark_winner! && player.update_rank(@total_winners += 1) if player.total_score >= @total_max_score
    player.update_last_score(current_score)
  end

  def player_skipable?(player, current_score)
    current_score.eql?(1) && current_score.eql?(player.last_score)
  end

  def roll_dice_again?(current_score, player)
    current_score.eql?(6) && !player.winner?
  end
end
