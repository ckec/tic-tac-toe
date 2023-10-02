# frozen_string_literal: true

require_relative 'player'

# Contains the logic to play the game
class Game
  WIN_COMBINATIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 5, 9],
    [3, 5, 7],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9]
  ].freeze

  attr_reader :available_positions

  def initialize
    @players = [
      Player.new(self, 'x', 'Player_1'),
      Player.new(self, 'o', 'Player_2')
    ]
    @current_player = @players[0]
    @board = %w[1 2 3 4 5 6 7 8 9]
    @available_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def play
    puts "\nNew game of Tic Tac Toe begins!"
    loop do
      puts "\nGame board:"
      p_board
      chosen_position = @current_player.choose_position
      update_available_positions(chosen_position)
      @board[chosen_position - 1] = @current_player.marker

      if winner?(@current_player)
        p_board
        puts "The winner is #{@current_player.name}!"
        again?
      elsif draw?
        p_board
        puts "It's a draw!"
        again?
      end
      switch_player
    end
  end

  private

  def p_board
    divider = '--+---+--'
    puts "\n#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts divider
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts divider
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}\n\n"
  end

  def update_available_positions(pos)
    @available_positions.delete(pos)
  end

  def winner?(player)
    WIN_COMBINATIONS.any? do |combination|
      combination.all? { |pos| @board[pos - 1] == player.marker }
    end
  end

  def draw?
    @available_positions.empty?
  end

  def switch_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def again?
    loop do
      print "\nPlay again: yes or no?\n"
      answer = gets.chomp.downcase
      if answer == 'yes'
        initialize
        play
      elsif answer == 'no'
        puts "\nGood game!"
        exit
      else
        puts "\nInvalid input!"
      end
    end
  end
end
