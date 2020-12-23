class PolyTreeNode
    attr_reader :value, :parent
    attr_accessor :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        if parent != nil && !parent.children.include?(self)
            if @parent != nil
                @parent.children.delete(self)
            end
            parent.children << self
        end
        @parent = parent
    end

    def add_child(node)
        node.parent = self
    end

    def remove_child(node)
        raise "#{node} is not a child!" if !@children.include?(node)
        node.parent = nil
    end

    def dfs(target_value)
        return self if target_value == @value
        @children.each do |child|
            search_result = child.dfs(target_value)
            return search_result if search_result != nil
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        while queue.length > 0
            search_result = queue.shift
            return search_result if search_result.value == target_value
            queue += search_result.children
        end
        nil
    end
end