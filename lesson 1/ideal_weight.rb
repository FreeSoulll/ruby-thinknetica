puts 'Ваше имя'
name = gets.chomp

puts 'Ваш Вес'
height = gets.chomp

perfect_weight = (height.to_i - 110) * 1.15

if perfect_weight > 0
  puts "#{name}, ваш идеальный вес - #{perfect_weight}"
else
  puts 'Ваш вес уже оптимальный'
end
