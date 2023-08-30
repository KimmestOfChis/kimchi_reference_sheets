# ==========================================================
# Quick Reference Sheet for Coding Interview Patterns in Ruby
# ==========================================================

# Sliding Window: "maximum/minimum subarray", "contiguous subarray"
# ---------------
def max_sum_subarray_of_size_k(arr, k)
  max_sum = -Float::INFINITY
  sum = 0
  start = 0

  arr.each_with_index do |n, end_|
    sum += n
    if end_ >= k - 1
      max_sum = [max_sum, sum].max
      sum -= arr[start]
      start += 1
    end
  end

  max_sum
end


# Two Pointers: "sorted array", "pair with given sum"
# --------------
def pair_with_target_sum(arr, target_sum)
  left = 0
  right = arr.length - 1

  while left < right
    current_sum = arr[left] + arr[right]
    return [left, right] if current_sum == target_sum

    if current_sum < target_sum
      left += 1
    else
      right -= 1
    end
  end

  [-1, -1]
end


# Fast & Slow Pointers: "cycle in linked list", "middle of the list"
# ----------------------
class Node
  attr_accessor :value, :next

  def initialize(value, next_node = nil)
    @value = value
    @next = next_node
  end
end

def has_cycle(head)
  slow = head
  fast = head

  while !fast.nil? && !fast.next.nil?
    fast = fast.next.next
    slow = slow.next
    return true if slow == fast
  end

  false
end


# Merge Intervals: "overlapping intervals", "merge ranges"
# ----------------
def merge_intervals(intervals)
  return [] if intervals.empty?

  intervals.sort_by!(&:first)
  merged = [intervals[0]]

  for i in 1...(intervals.size)
    current = intervals[i]
    last_merged = merged[-1]

    if current[0] <= last_merged[1]
      last_merged[1] = [last_merged[1], current[1]].max
    else
      merged << current
    end
  end

  merged
end


# Cyclic Sort: "sorted array with numbers from 1 to N", "missing numbers"
# -------------
def cyclic_sort(nums)
  i = 0
  while i < nums.length
    j = nums[i] - 1
    if nums[i] != nums[j]
      nums[i], nums[j] = nums[j], nums[i]
    else
      i += 1
    end
  end
  nums
end


# In-place Reversal of a Linked List: "reverse a linked list", "in-place"
# -----------------------------------
def reverse_linked_list(head)
  prev = nil
  current = head

  while !current.nil?
    next_temp = current.next
    current.next = prev
    prev = current
    current = next_temp
  end

  prev
end


# Breadth-First Search (BFS): "level order traversal", "shortest path"
# ----------------------------
class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

def level_order_traversal(root)
  return [] if root.nil?

  queue = []
  queue << root
  result = []

  while !queue.empty?
    level_size = queue.size
    current_level = []

    level_size.times do
      current_node = queue.shift
      current_level << current_node.value

      queue << current_node.left if current_node.left
      queue << current_node.right if current_node.right
    end

    result << current_level
  end

  result
end


# Depth-First Search (DFS): "tree path", "sum of paths"
# --------------------------
def find_path(root, sequence)
  return false if root.nil?

  find_path_recursive(root, sequence, 0)
end

def find_path_recursive(current_node, sequence, sequence_index)
  return false if current_node.nil?

  if sequence_index >= sequence.length || current_node.value != sequence[sequence_index]
    return false
  end

  if current_node.left.nil? && current_node.right.nil? && sequence_index == sequence.length - 1
    return true
  end

  find_path_recursive(current_node.left, sequence, sequence_index + 1) ||
    find_path_recursive(current_node.right, sequence, sequence_index + 1)
end

