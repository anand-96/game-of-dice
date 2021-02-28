# frozen_string_literal: true

require "faker"
require_relative "../app/game"

RSpec.describe Player do # rubocop:disable Metrics/BlockLength
  let(:name) { Faker::Name.first_name }

  subject { described_class.new(name) }

  context "#initialize" do
    it "should initialize player with default configurations" do
      expect(subject.name).to eq(name)
      expect(subject.rank).to eq(0)
      expect(subject.total_score).to eq(0)
      expect(subject.last_score).to eq(0)
    end
  end

  context "#skip_turn?" do
    it "should set skip_turn = true if player mark_skip" do
      subject.mark_skip!
      expect(subject.skip_turn?).to be_truthy
    end

    it "should set skip_turn = false if player unmark_skip" do
      subject.unmark_skip!
      expect(subject.skip_turn?).to be_falsy
    end
  end

  context "#winner?" do
    it "should set is_winner = true if player mark_winner" do
      subject.mark_winner!
      expect(subject.winner?).to be_truthy
    end
  end

  context "#update_total_score" do
    it "should update total_score" do
      updated_score = Faker::Number.between(from: 1, to: 10)
      subject.update_total_score(updated_score)
      expect(subject.total_score).to eq(updated_score)
    end
  end

  context "#dashboad_summary" do
    it "should return dashboad_summary" do
      summary = "#{subject.rank.zero? ? "-" : subject.rank} | #{subject.name} | #{subject.total_score}"
      expect(subject.dashboad_summary).to eq(summary)
    end
  end
end
