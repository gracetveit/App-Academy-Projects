require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
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
          new_board[pos] = next_mover_mark

          if next_mover_mark == :o
            new_mover_mark = :x
          else
            new_mover_mark = :o
          end

          new_arr << TicTacToeNode.new(new_board, new_mover_mark, pos)
        end
      end
    end

    new_arr
  end
end
