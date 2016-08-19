require_relative 'tic_tac_toe'
require "byebug"
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    # debugger
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
    # debugger
    @board.rows.each do |row|
      row.each do |cell|
        if cell.nil?
          next_mover_mark == :x ? next_mover_mark = :o : next_mover_mark = :x
          new_node = TicTacToeNode.new(@board.dup, next_mover_mark, @prev_move_pos)
        end
      end
    end
  end

end
