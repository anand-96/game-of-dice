# frozen_string_literal: true

require "pry"
require "faker"
require_relative "../../lib/constant"

RSpec.describe GameCli do # rubocop:disable Metrics/BlockLength
  subject { described_class.instance }
  let(:player_name) { Faker::Name.first_name }

  context "#introduction" do
    it "should display about the game banner and introduction" do
      expect(subject.cli).to receive(:say).with(Constant::GAME_INTRODUCTION)
      expect(subject.cli).to receive(:say).with(Constant::GAME_BANNER)
      subject.introduction
    end
  end

  context "#prompt_player_turn" do
    it "should display player turm message" do
      expect(subject.cli).to receive(:ask).with("\n#{player_name} its your turn (press 'r' to roll the dice)")
      subject.send(:prompt_player_turn, player_name)
    end
  end

  context "#prompt_skip_player" do
    it "should display skip player message" do
      expect(subject.cli).to receive(:say)
        .with("\n => Oops! #{player_name}, you can throw dice in next turn, your turn is skip")
      subject.send(:prompt_skip_player, player_name)
    end
  end

  context "#print_dice_result" do
    it "for dice score = 6" do
      expect(subject.cli).to receive(:say).with("\n => Nice!, #{player_name} got 6 points, Roll again ...")
      subject.send(:print_dice_result, player_name, 6)
    end

    it "for dice score in 1 to 5" do
      expect(subject.cli).to receive(:say).with("\n => #{player_name} got 5 points")
      subject.send(:print_dice_result, player_name, 5)
    end
  end

  context "#congratulate_player" do
    it "should congratulate player with rank = 1" do
      expect(subject.cli).to receive(:say).with("\nCongratulations #{player_name} !!! You secured 1 rank")
      subject.send(:congratulate_player, player_name, 1)
    end
  end
end
