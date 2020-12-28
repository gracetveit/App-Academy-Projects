require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def inverse_mark(mark)
    if mark == :o
      return :x
    else
      return :o
    end
  end

  def losing_node?(evaluator)
    opponent = self.inverse_mark(evaluator)
    # Base Case
    if @board.over?
      if @board.winner == opponent
        return true
      else
        return false
      end
    end
    # Recursive Case
    # Players turn, all children nodes are losers
    if @next_mover_mark == evaluator
      return self.children.all? { |child| child.losing_node?(evaluator) }
    else
      # Or it's opponents turn, and one of the children nodes is a losing node
      return self.children.any? { |child| child.losing_node?(evaluator) }
    end
    
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_arr = []

    # Every empty node do: make a dupe board w/ `next mover mark` in the
    # pos. Alternate `next_mover_mark`, and set `prev_move_pos` to the pos
    # marked.
    @board.rows.each_with_index do |row, y|
      row.each_with_index do |e, x|
        pos = [x, y]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = @next_mover_mark

          new_mover_mark = self.inverse_mark(new_mover_mark)

          new_arr << TicTacToeNode.new(new_board, new_mover_mark, pos)
        end
      end
    end

    new_arr
  end
end
