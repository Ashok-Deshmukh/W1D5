require "byebug"
class PolyTreeNode

  attr_reader :value, :children, :parent
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    old_parent = @parent
    if old_parent
      old_parent.children.reject! { |child| child == self }
    end
    @parent = node
    node.children << self unless node.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise "#{child} is not a child!" if !self.children.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      this_node = queue.shift
      return this_node if this_node.value == target_value
      queue.concat(this_node.children)
    end
  end

end
