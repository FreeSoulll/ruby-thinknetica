puts 'Сторона А'
a = gets.chomp.to_i

puts 'Сторона B'
b = gets.chomp.to_i

puts 'Сторона C'
c = gets.chomp.to_i

sides = [a, b, c].sort

if a == b && a == c
  puts 'Треугольник равносторонний'
elsif (a == b) || (a == c) || (b == c)
  puts 'Треугольник равнобедренный'
elsif sides[0]**2 + sides[1]**2 == sides[2]**2
  puts 'Треугольник прямоугольный'
else
  puts 'Треугольник не подходит под нужные условия'
end