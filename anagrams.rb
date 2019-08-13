def first_anagram?(str_1, str_2)
  str_1.split("").permutation.to_a.map(&:join).include?(str_2)
end

def anagrams(str)
  return [str] if str.length == 1

  anas = []
  first_char = str[0]
  sub_anas = anagrams(str[1..-1])

  sub_anas.each do |sub_ana|
    chars = sub_ana.split("")
    (0..sub_ana.length).each do |idx|
      new_chars = chars.take(idx) + [first_char] + chars.drop(idx)
      anas << new_chars.join
    end
  end

  anas
end

partial_alpha = ("a".."z").to_a * 100000

p first_anagram?("gizmo", "sally")    #=> false
p first_anagram?("elvis", "lives")    #=> true
t1 = Time.now
# p first_anagram?(partial_alpha.join, partial_alpha.shuffle.join) #=> true
p Time.now - t1

# time complexity: O(n!)
# length 1: 1
# length 2: 1 * 2
# length 3: 1 * 2 * 3

# space complexity: O(n!), or at least the result is n! elements long

def second_anagram?(str_1, str_2)
  chars_2 = str_2.split("")

  str_1.each_char do |char|
    if chars_2.include?(char)
      chars_2.delete_at(chars_2.find_index(char))
    else
      return false
    end
  end

  chars_2.empty?
end

p second_anagram?("gizmo", "sally")    #=> false
p second_anagram?("elvis", "lives")    #=> true
t1 = Time.now
#p second_anagram?(partial_alpha.join, partial_alpha.shuffle.join) #=> true
p Time.now - t1

# time complexity: O(n^2) because within each loop we have another operation of O(n)
# space complexity: O(n) because array created was base on the input(n)'s length


def third_anagram?(str_1, str_2)
  str_1.split("").sort == str_2.split("").sort
end

p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("elvis", "lives")    #=> true
t1 = Time.now
p third_anagram?(partial_alpha.join, partial_alpha.shuffle.join) #=> true
p Time.now - t1

# time complexity: O(nlog(n)) because the .sort is the bottle neck
# space complexity: O(n) because we have to store 2n of chars for .sort(quick sort)


def fourth_anagram?(str_1, str_2)
  counts_1 = Hash.new(0)
  #counts_2 = Hash.new(0)

  str_1.each_char { |char| counts_1[char] += 1 }
  str_2.each_char { |char| counts_1[char] -= 1 }

  #counts_1 == counts_2
  counts_1.values.all? { |value| value == 0 }
end

p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("elvis", "lives")    #=> true
t1 = Time.now
p third_anagram?(partial_alpha.join, partial_alpha.shuffle.join) #=> true
p Time.now - t1

# time complexity: O(n) => 2 + n (each_char) + n (each_char) + num_uniq_chars_in_alpha ( == )
# space complexity: O(1)