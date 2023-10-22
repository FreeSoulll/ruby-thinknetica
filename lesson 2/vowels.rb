letters_arr = {}
vowels = ['a', 'e', 'i', 'o', 'u', 'y'] 

('a'..'z').each_with_index do |key, index|
  letters_arr[key] = index + 1 if vowels.include?(key)
end

puts letters_arr
