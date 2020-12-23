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
end