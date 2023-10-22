items = {}
final_price = 0

loop do
  puts 'Название товара'
  name = gets.chomp.to_sym
  break if name == 'стоп'.to_sym

  puts 'Цена за единицу'
  item_price = gets.chomp.to_i

  puts 'Количество товара'
  item_quantity = gets.chomp.to_f

  items[name] = { price: item_price, quantity: item_quantity }
end

items.each do |product, value|
  price = value[:price] * value[:quantity]

  puts "Товар: #{product}\nЦена за ед.: #{value[:price]}\nКол-во ед. товара: #{value[:quantity]}"
  puts "Финальная цена на товар #{product} - #{price}"

  final_price += price
end

puts "Финальная цена на все продукты - #{final_price}"
