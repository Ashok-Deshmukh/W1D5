require_relative "00_tree_node"

class KnightPathFinder
  attr_reader :position, :root
  MOVES = [
    [-2, -1],
    [-2, 1],
    [-1, 2],
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2]
  ]
  def initialize(position = [0, 0])
    @position = position
    @visited_positions = [position]
    build_move_tree
  end

  def self.valid_moves(pos)
    pos_x, pos_y = pos
    possible_moves = MOVES.map do |x, y|
      [pos_x + x, pos_y + y]
    end
    moves_on_board = possible_moves.reject do |x, y|
      (x > 7 || x < 0) || (y > 7 || y < 0)
    end
  end

  def new_move_positions(pos)
    new_valid_moves = self.class.valid_moves(pos).reject { |p| @visited_positions.include?(p)}
    @visited_positions.concat(new_valid_moves)
    new_valid_moves
  end

  def build_move_tree
    @root = PolyTreeNode.new(position)
    queue = [@root]
    counter = 0
    until queue.empty?
      this_node = queue.shift
      new_move_positions(this_node.value).each do |pos|
        new_node = PolyTreeNode.new(pos)
        this_node.add_child(new_node)
        queue.concat([new_node])
      end
    end
  end

  def find_path(end_position)
    @root.dfs(end_position)
  end

  def trace_path_back(end_position)
      destination = self.find_path(end_position)
      result = [destination.value]
      debugger
      until result.first == @root.value
        result.unshift(destination.parent.value)
        destination = destination.parent
      end
      result
  end
end
