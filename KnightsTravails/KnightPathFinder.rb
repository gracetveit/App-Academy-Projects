require_relative "PolyTreeNode"
class KnightPathFinder
    def self.valid_moves(pos)
        arr = [p]
        x = pos[0]
        y = pos[1]
        positions = [
            [x + 1, y + 2],
            [x + 1, y - 2],
            [x - 1, y + 2],
            [x - 1, y - 2],
            [x + 2, y + 1],
            [x + 2, y - 1],
            [x - 2, y + 1],
            [x - 2, y - 1]
        ]
        board_limits = (0...8)
        positions.select! do |subarray|
            subarray.all? { |e| board_limits.include?(e)}
        end
        positions
    end

    def initialize (starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]
        @move_tree = build_move_tree
    end

    def new_move_positions(pos)
        positions = KnightPathFinder.valid_moves(pos)
        positions.select! { |e| !@considered_positions.include?(e)}
        @considered_positions += positions
        positions
    end

    def build_move_tree
        queue = [@root_node]
        while queue.length > 0 do
            current_pos = queue.shift
            possible_moves = self.new_move_positions(current_pos.value)
            possible_moves.each do |move|
                move_node = PolyTreeNode.new(move)
                current_pos.add_child(move_node)
                queue << move_node
                @considered_positions
            end
        end
    end
end