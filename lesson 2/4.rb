
letters_arr = []
vowels = ['a', 'e', 'i', 'o', 'u', 'y'] 

('a'..'z').each_with_index {|key, index| letters_arr << index + 1 if vowels.include?(key) }

puts letters_arr
