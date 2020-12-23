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
end