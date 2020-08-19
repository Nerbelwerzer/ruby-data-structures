# frozen_string_literal: true

# node class
class Node
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# tree class
class Tree
  def initialize(arr = [])
    arr.sort!.uniq!
    @root = build_tree(arr, 0, arr.length)
  end

  def build_tree(arr, start, stop)
    return nil if start > stop

    middle = (start + stop) / 2
    node = Node.new(arr[middle])
    node.left = build_tree(arr, start, middle - 1)
    node.right = build_tree(arr, middle + 1, stop)
    node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data.nil? || node.data == value

    return find(value, node.right) if value > node.data

    find(value, node.left)
  end

  def insert(value)
    node = Node.new(value)
    return @root = node if @root.data.nil?

    _insert(node)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def _insert(new_node, parent_node = @root)
    if parent_node.data < new_node.data
      if parent_node.right.nil?
        parent_node.right = new_node
      else
        _insert(new_node, parent_node.right)
      end
    elsif parent_node.left.nil?
      parent_node.left = new_node
    else
      _insert(new_node, parent_node.left)
    end
  end
end

# test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
test = Tree.new
p = test.find(67)
puts p
test.insert(6)
test.insert(2)
test.insert(10)

test.pretty_print
