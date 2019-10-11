class TicTacToe
  def initialize(game_board=Array.new(9, " "))
    @board = game_board
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, player_token = "X")
    @board[index] = player_token
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      return false
    else
      return true
    end
  end

  def valid_move?(index)
    if position_taken?(index) == false && index.between?(0, 8) == true
      return true
    else
      return false
    end
  end

  def turn_count
    counter = 0
    @board.each do |cell|
      if cell == "X" || cell == "O"
        counter += 1
      end
    end
    return counter
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    player_token = current_player
    if valid_move?(index)
      move(index, player_token)
      display_board
    else turn
    end
  end

  def won?
    WIN_COMBINATIONS.each do |win_combination|

      win_1 = win_combination[0]
      win_2 = win_combination[1]
      win_3 = win_combination[2]

      board_1 = @board[win_1]
      board_2 = @board[win_2]
      board_3 = @board[win_3]

      if (board_1 == "X" && board_2 == "X" && board_3 == "X") || (board_1 == "O" && board_2 == "O" && board_3 == "O")
        return win_combination
      end
    end
    return false
  end

  def full?
    @board.none? do |position|
      position == " "
    end
  end

  def draw?
    won = won?
    full = full?
    if !won && full
      return true
    end
  end

  def over?
    won = won?
    full = full?
    draw = draw?
    if won || full || draw
      return true
    end
  end

  def winner
    won = won?
    if won
      return @board[won[0]]
    else return
    end
  end

  def play
    until over? == true
      turn
    end
    if won?
      puts "Congratulations #{winner}! You won the game."
    elsif draw?
      puts "It's a draw!"
    end
  end
end
