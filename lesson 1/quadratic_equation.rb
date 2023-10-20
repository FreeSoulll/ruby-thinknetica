puts 'коэффициент А'
a = gets.chomp.to_i

puts 'коэффициент B'
b = gets.chomp.to_i

puts 'коэффициент C'
c = gets.chomp.to_i

d = b**2 - 4 * a * c

if d > 0
  puts "Первый корень - #{(-b + Math.sqrt(b)) / (2 * a)}"
  puts "Второй корень - #{(-b - Math.sqrt(b)) / (2 * a)}"
  puts "Дискриминнат - #{d}"
elsif d == 0
  puts "Корень - #{-b/(2 * a)}"
  puts "Дискриминнат - #{d}"
else
  puts "Дискриминнат - #{d}"
  puts 'Корней нет'
end
