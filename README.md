# Game Of Dice

## Introduction
The "Game of Dice" is a multiplayer game where N players roll a 6 faced dice in a round-robin
fashion. Each time a player rolls the dice their points increase by the number (1 to 6) achieved
by the roll.

As soon as a player accumulates M points they complete the game and are assigned a rank.
Remaining players continue to play the game till they accumulate at least M points. The game
ends when all players have accumulated at least M points.

## Game Rules
* The order in which the users roll the dice is decided randomly at the start of the game.
* If a player rolls the value "6" then they immediately get another chance to roll again and move
ahead in the game.
* If a player rolls the value "1" two consecutive times then they are forced to skip their next turn
as a penalty.

## Prerequisites
* Bundler version: 2.2.8
* Ruby version : 3.0.0
* Rails Version : 6.1.3

## Setup
```gem install bundler && bundle install```

## Play the Game of Dice
```ruby start.rb```

## Run Linter
```rubocop```

## Code coverage
### Run the Test Cases
```rspec```

## List of Gems used
* [highline](https://github.com/JEG2/highline) used as a command line interface (CLI) for user.
* [rubocop](https://github.com/rubocop/rubocop) for code linting
* [rspec](https://github.com/rspec/rspec) for writing testcases, [faker](https://github.com/faker-ruby/faker) to generates fake data and [simplecov](https://github.com/simplecov-ruby/simplecov) for code coverage.
