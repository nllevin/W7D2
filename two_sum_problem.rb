def bad_two_sum?(integers, target_sum)
  integers.each do |int_1|
    integers.each do |int_2|
      next if int_1 == int_2
      return true if int_1 + int_2 == target_sum
    end
  end
  false
end

arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6) # => should be true
p bad_two_sum?(arr, 10) # => should be false

# time complexity: O(n^2) because doubly nested loop
# space complexity: O(1) because two variables that store integers


def okay_two_sum?(integers, target_sum)
  sorted_integers = integers.sort
  integers.each do |integer|
    remainder = target_sum - integer
    next if remainder == integer
    return true unless bsearch(sorted_integers, remainder).nil?
  end
  false
end

def bsearch(array, target)
  return nil if array.empty?
  probe = array.length / 2
  case target <=> array[probe]
  when -1
    bsearch(array.take(probe), target)
  when 0
    probe
  when 1
    result = bsearch(array.drop(probe + 1), target)
    return result unless result.nil?
  end
end

arr = [0, 1, 5, 7]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false

# time complexity: at least O(n*log(n)) because .sort
#  overall still O(n*log(n)) because each loop(n), and the bsearch is log(n)
# space complexity: O(n), n(.sort) + n(bsearch) 


def two_sum?(integers, target_sum)
  int_hash = Hash.new(false)
  integers.each { |integer| int_hash[integer] = true }
  integers.each do |integer|
    remainder = target_sum - integer
    next if remainder == integer
    return true if int_hash[remainder]  # int_hash.has_key?(remainder) => O(n)
  end
  false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false

# time complexity: O(n) for single, consecutive (non-nested) each loops that themselves contain O(1) operations
# space complexity: O(n) because the number of keys in the hash depends on length of the integers array