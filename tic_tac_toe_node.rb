require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :prev_move_pos, :board, :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return false if @board.winner.nil? || @board.winner == evaluator
      return true
    end

    if @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return false if @board.winner.nil? || @board.winner != evaluator
      return true if @board.winner == evaluator
    end

    if @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |x|
      (0..2).each do |y|
        pos = [x, y]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = @next_mover_mark
          next_mark = @next_mover_mark == :x ? :o : :x
          children << TicTacToeNode.new(new_board, next_mark, pos)
        end
      end
    end
    children
  end
end
