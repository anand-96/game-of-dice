# frozen_string_literal: true

# Configurable constants throughout the system
class Constant
  GAME_BANNER = "!!!================ Welcome to the Game of Dice ========================!!!\n\n\n"
  GAME_INTRODUCTION = "The \"Game of Dice\" is a multiplayer game where N players roll a 6 faced dice in a round-robin
  fashion. Each time a player rolls the dice their points increase by the number (1 to 6) achieved by the roll.
  As soon as a player accumulates M points they complete the game and are assigned a rank.
  Remaining players continue to play the game till they accumulate at least M points.
  The game ends when all players have accumulated at least M points.\n\n"
  MIN_PLAYERS = 2
  MAX_PLAYERS = 50
  GAME_RULES = "Rules of the game:
  - The order in which the users roll the dice is decided randomly at the start of the game.
  - If a player rolls the value \"6\" then they immediately get another chance to roll again and move ahead in the game.
  - If a player rolls the value \"1\" two consecutive times then they are forced to skip their next turn
    as a penalty.\n\n"
  DICE_SIDES = 6
end
