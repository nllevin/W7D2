require 'byebug'

# Given a list of integers find the smallest number in the list.

def compare_every_element_my_min(integers)
  min = nil

  integers.each do |integer_1|
    is_min = true

    integers.each do |integer_2|
      is_min = false if integer_1 > integer_2
    end

    min = integer_1 if is_min
    break if min
  end

  min
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p compare_every_element_my_min(list)  # =>  -5
# time complexity: O(n^2) because nested loops
# space complexit: O(1) because only a few variables, always reassigned to one value

def iterate_once_my_min(integers)
  min = integers.first
  integers.each do |integer|
    min = integer if integer < min
  end
  min
end

p iterate_once_my_min(list)  # =>  -5
# time complexity: O(n) because single loop
# space complexity: O(1) because variables only reassigned within loop


# Largest Contiguous Sub-sum

def all_subarrays_largest_contiguous_subsum(integers)
  subarrays = []
  (0...integers.length).each do |start_i|             # n start_i's ????
    (start_i...integers.length).each do |end_i|       # average of n/2 end_i's ????
      subarrays << integers[start_i..end_i]           # average number of elements in each subarray is n/2 ????
    end
  end
  p "Number of subarrays: #{subarrays.length}"
  p "'Memory space': #{subarrays.flatten.length}"
  subarrays.map(&:sum).max
end

list1 = [5, 3, -7]
p all_subarrays_largest_contiguous_subsum(list1) # => 8

list2 = [2, 3, -6, 7, -6, 7]
p all_subarrays_largest_contiguous_subsum(list2) # => 8 (from [7, -6, 7])

list3 = [-5, -1, -3]
p all_subarrays_largest_contiguous_subsum(list3) # => -1 (from [-1])

# Time complexity: O(n^3) because the doubly nested loops (O(n^2)) and array slicing inside second loop (O(n))
# Space complexity: ????


def running_tally_largest_contiguous_subsum(integers)
  max_sum = integers.first
  local_sum = integers.first
  (1...integers.length).each do |idx|
    current_int = integers[idx]
    if current_int + local_sum > 0
      local_sum += current_int
    elsif max_sum.positive?
      local_sum = 0
    elsif current_int > local_sum
      local_sum = current_int
    end
    
    max_sum = local_sum if local_sum > max_sum
  end
  max_sum
end

list1 = [5, 3, -7]
p running_tally_largest_contiguous_subsum(list1) # => 8

list2 = [2, 3, -6, 7, -6, 7]
p running_tally_largest_contiguous_subsum(list2) # => 8 (from [7, -6, 7])

list3 = [-5, -3, -1]
p running_tally_largest_contiguous_subsum(list3) # => -1 (from [-1])

# Time complexity: O(n) because one loop through n elements
# Space complexity: O(1) because we only have 3 variables that get reassigned