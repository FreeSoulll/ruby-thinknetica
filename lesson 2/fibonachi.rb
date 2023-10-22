fibonacci_arr = [0, 1]

while fibonacci_arr.last <= 100
  next_number = fibonacci_arr[-1] + fibonacci_arr[-2]
  break if next_number >= 100

  fibonacci_arr << next_number
end

puts fibonacci_arr
