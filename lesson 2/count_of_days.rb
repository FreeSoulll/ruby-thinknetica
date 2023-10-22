months_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Укажите число'
number = gets.chomp.to_i

puts 'Укажите месяц'
month = gets.chomp.to_i

puts 'Укажите год'
year = gets.chomp.to_i

months_days[1] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

ordinal_number = number
(0..month - 2).each do |i|
  ordinal_number += months_days[i]
end

puts ordinal_number
