# frozen_string_literal: true

require "faker"
require_relative "../app/game"

RSpec.describe Game do # rubocop:disable Metrics/BlockLength
  let(:number_of_players) { Faker::Number.between(from: 1, to: 5) }
  let(:total_max_score) { Faker::Number.between(from: 1, to: 10) }

  subject { described_class.new(number_of_players, total_max_score) }

  context "#initialize" do
    it "should initialize game with default configurations" do
      expect(subject.players.count).to be(number_of_players)
      expect(subject.players.first.name).to eq("Player 1")
      expect(subject.players.first.rank).to eq(0)
      expect(subject.players.first.total_score).to eq(0)
      expect(subject.players.first.last_score).to eq(0)
    end
  end

  context "#play_turn" do
    it "should skip turn if both player roll dice and last score is 1" do
      player = subject.players[0]
      expect_any_instance_of(Game).to receive(:roll_dice).with(player).and_return(1)
      expect_any_instance_of(Player).to receive(:last_score).and_return(1)

      message = "\n => Oops! #{player.name}, you can throw dice in next turn, your turn is skip"
      expect(GameCli.instance.cli).to receive(:say).with(message)
      subject.send(:play_turn, player)
    end

    it "should mark player as skip if both player roll dice and last_score is 1" do
      player = subject.players[0]
      expect_any_instance_of(Game).to receive(:roll_dice).with(player).and_return(1)
      expect_any_instance_of(Player).to receive(:last_score).and_return(1)
      player.mark_skip!
      expect(player.skip_turn?).to be_truthy
      subject.send(:play_turn, player)
    end

    it "should congratulate player for winning the game" do
      player = subject.players[0]
      player.mark_winner!
      player.update_rank(1)
      expect_any_instance_of(Game).to receive(:roll_dice).with(player).and_return(6)

      message = "\nCongratulations #{player.name} !!! You secured #{player.rank} rank"
      expect(GameCli.instance.cli).to receive(:say).with(message)
      subject.send(:play_turn, player)
    end
  end
end
