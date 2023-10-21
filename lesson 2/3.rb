fibonacci_arr = [0, 1]

while fibonacci_arr.last <= 100
next_number = fibonacci_arr[-1] + fibonacci_arr[-2]
fibonacci_arr << next_number 
end

fibonacci_arr.pop if fibonacci_arr.last >= 100

puts fibonacci_arr