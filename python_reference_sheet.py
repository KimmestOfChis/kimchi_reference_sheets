# ==========================================================
# Quick Reference Sheet for Coding Interview Patterns in Python
# ==========================================================

# Sliding Window: "maximum/minimum subarray", "contiguous subarray"
# ---------------
def max_sum_subarray_of_size_k(arr, k):
    max_sum = float('-inf')
    window_sum = 0
    window_start = 0
    
    for window_end in range(len(arr)):
        window_sum += arr[window_end]
        
        if window_end >= k - 1:
            max_sum = max(max_sum, window_sum)
            window_sum -= arr[window_start]
            window_start += 1
    
    return max_sum

# Two Pointers: "sorted array", "pair with given sum"
# --------------
def pair_with_target_sum(arr, target_sum):
    left, right = 0, len(arr) - 1
    
    while left < right:
        current_sum = arr[left] + arr[right]
        
        if current_sum == target_sum:
            return [left, right]
        
        if current_sum < target_sum:
            left += 1
        else:
            right -= 1
    
    return [-1, -1]

# Breadth-First Search (BFS): "level order traversal", "shortest path"
# ----------------------------
class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

def level_order_traversal(root):
    if not root:
        return []
    
    result = []
    queue = [root]
    
    while queue:
        level_size = len(queue)
        current_level = []
        
        for _ in range(level_size):
            current_node = queue.pop(0)
            current_level.append(current_node.value)
            
            if current_node.left:
                queue.append(current_node.left)
            if current_node.right:
                queue.append(current_node.right)
        
        result.append(current_level)
    
    return result

# Depth-First Search (DFS): "tree path", "sum of paths"
# --------------------------
def find_path(root, sequence):
    if not root:
        return False
    
    return find_path_recursive(root, sequence, 0)

def find_path_recursive(current_node, sequence, sequence_index):
    if not current_node:
        return False
    
    if sequence_index >= len(sequence) or current_node.value != sequence[sequence_index]:
        return False
    
    if current_node.left is None and current_node.right is None and sequence_index == len(sequence) - 1:
        return True
    
    return find_path_recursive(current_node.left, sequence, sequence_index + 1) or \
           find_path_recursive(current_node.right, sequence, sequence_index + 1)

