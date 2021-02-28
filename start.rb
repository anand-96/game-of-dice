# frozen_string_literal: true

require "./lib/game_cli"

game_cli = GameCli.instance
game_cli.introduction
game_cli.start_game
