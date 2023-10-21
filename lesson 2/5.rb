months_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Укажите число"
number = gets.chomp.to_i

puts "Укажите месяц"
month = gets.chomp.to_i

puts "Укажите год"
year = gets.chomp.to_i

ordinal_number = number

(0..month-2).each do |i|
ordinal_number += months_days[i]
end

ordinal_number += 1 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

puts ordinal_number
