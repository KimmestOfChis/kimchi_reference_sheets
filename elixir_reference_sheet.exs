# ==========================================
# Quick Reference Sheet for Elixir Interview Patterns
# ==========================================

# Sliding Window: "maximum/minimum subarray", "contiguous subarray"
# ---------------
def max_sum_subarray_of_size_k(arr, k) do
  {max_sum, _} =
    Enum.reduce_while(arr, {-:infinity, {0, 0, 0}}, fn x, {-max_sum, {sum, start, end}} ->
      sum = sum + x
      {sum, start, end} = if end - start + 1 >= k, do: {sum - Enum.at(arr, start), start + 1, end + 1}, else: {sum, start, end + 1}
      {:cont, {max(max_sum, sum), {sum, start, end}}}
    end)

  max_sum
end

# Two Pointers: "sorted array", "pair with given sum"
# --------------
def pair_with_target_sum(arr, target_sum) do
  pair_with_target_sum(arr, target_sum, 0, length(arr) - 1)
end

defp pair_with_target_sum(_, _, start, end) when start >= end, do: {:error, "No pair found"}
defp pair_with_target_sum(arr, target_sum, start, end) do
  current_sum = Enum.at(arr, start) + Enum.at(arr, end)
  
  cond do
    current_sum == target_sum -> {start, end}
    current_sum < target_sum -> pair_with_target_sum(arr, target_sum, start + 1, end)
    true -> pair_with_target_sum(arr, target_sum, start, end - 1)
  end
end

# Breadth-First Search (BFS): "level order traversal", "shortest path"
# ----------------------------
defmodule TreeNode do
  defstruct value: nil, left: nil, right: nil
end

def level_order_traversal(root) do
  level_order_traversal(root, [[]])
end

defp level_order_traversal(nil, acc), do: Enum.reverse(acc)
defp level_order_traversal(root, acc) do
  queue = [root]
  level_order_traversal(queue, acc)
end

defp level_order_traversal([], acc), do: Enum.reverse(acc)
defp level_order_traversal(queue, acc) do
  {values, next_queue} = Enum.reduce(queue, {[], []}, fn
    %TreeNode{value: nil}, {vals, next_q} -> {vals, next_q}
    %TreeNode{value: value, left: left, right: right}, {vals, next_q} ->
      {vals ++ [value], next_q ++ Enum.filter([left, right], fn x -> x != nil end)}
  end)

  level_order_traversal(next_queue, [values | acc])
end

# Depth-First Search (DFS): "tree path", "sum of paths"
# --------------------------
def find_path(root, sequence) do
  find_path(root, sequence, 0)
end

defp find_path(nil, _, _), do: false
defp find_path(%TreeNode{value: value, left: left, right: right}, sequence, index) do
  if index >= length(sequence) or Enum.at(sequence, index) != value, do: false, else:
    if left == nil and right == nil and index == length(sequence) - 1, do: true, else:
      find_path(left, sequence, index + 1) or find_path(right, sequence, index + 1)
    end
  end
end

