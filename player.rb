# frozen_string_literal: true

# Contains logic for the player class
class Player
  attr_reader :name, :marker

  def initialize(tictactoe, marker, name)
    @tictactoe = tictactoe
    @marker = marker
    @name = name
  end

  def choose_position
    loop do
      puts "Choose a tile #{name}"
      chosen_position = gets.chomp.to_i
      return chosen_position if @tictactoe.available_positions.include?(chosen_position)

      puts "\nInvalid input."
    end
  end
end
