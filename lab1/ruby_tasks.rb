def validate_array(array, min_zeros = 0, min_length = 0)
  raise ArgumentError, "Array cannot be empty" if array.empty?
  raise ArgumentError, "Array must contain at least #{min_zeros} zeros" if array.count(0) < min_zeros
  raise ArgumentError, "Array must have at least #{min_length} elements" if array.size < min_length
end

def validate_k(k, is_integer = false)
  raise ArgumentError, "K must be a number" unless k.is_a?(Numeric)
  raise ArgumentError, "K must be an integer" if is_integer && !k.is_a?(Integer)
end

# 1. Дано цілочисельний масив. Знайти мінімальний і максимальний елемент у масиві.
array = [5, 2, 9, 1, 6, 7]
validate_array(array)
min, max = array.minmax

# 2. Дано цілочисельний масив. Поміняти місцями мінімальний і максимальний елементи масиву.
array = [5, 2, 9, 2, 1, 7]
validate_array(array)
min_index, max_index = array.each_with_index.minmax_by { |value, _| value }.map(&:last)
array[min_index], array[max_index] = array[max_index], array[min_index]

# 3. Дано цілочисельний масив. Переставити у зворотному порядку елементи масиву, розташовані між його мінімальним і максимальним елементами.
array = [5, 9, 2, 4, 3, 3, 6, -4]
validate_array(array)
min_index, max_index = array.each_with_index.minmax_by { |value, _| value }.map(&:last)
range_start, range_end = [min_index, max_index].minmax

array[range_start + 1..range_end - 1] = array[range_start + 1..range_end - 1].reverse if range_end - range_start > 1

# 4. Дано цілочисельний масив і ціле число К. Звести до степеня К усі елементи масиву.
array = [2, 3, 4, 5]
validate_array(array)
k = 3
validate_k(k, true)
raise ArgumentError, "K must be an integer" unless k.is_a?(Integer)
array.map! { |element| element**k }

# 5. Дано цілочисельний масив, що містить принаймні два нулі. Вивести суму чисел з даного масиву, розташованих між останніми двома нулями.
array = [1, 3, 0, 4, 5, 0, 6, 1, 0]
validate_array(array, 2)
last_zero_index = array.rindex(0)
second_last_zero_index = array[0...last_zero_index].rindex(0)

if second_last_zero_index && last_zero_index && last_zero_index - second_last_zero_index > 1
  sum = array[second_last_zero_index + 1...last_zero_index].sum
else
  sum = 0
end

# 6. Дано натуральне число N. Знайти результат наступного добутку 1*2*...*N.
n = 5
raise ArgumentError, "Number must be non-negative" if n < 0
factorial = (1..n).inject(1, :*)

# 7. Дано натуральне число N. Якщо N - непарне, то знайти добуток 1*3*...*N; якщо N - парне, то знайти добуток 2*4*...*N.
n = 5
raise ArgumentError, "N must be a natural number" if n < 1
if n.odd?
  product = (1..n).step(2).inject(1, :*)
else
  product = (2..n).step(2).inject(1, :*)
end

# 8. Дано цілочисельний масив. Підвести до квадрата від'ємні елементи і до третього степеня - додатні. Нульові елементи - не змінювати.
array = [-2, 0, 3, -1, 4, 0, -5, 6]
validate_array(array)

result = array.map do |element|
  if element < 0
    element ** 2
  elsif element > 0
    element ** 3
  else
    element
  end
end

# 9-10. Дано дипапазон a..b. Отримати масив із чисел, розташованих у цьому діапазоні (за винятком самих цих чисел), у порядку їхнього зростання, а також розмір цього масиву.
a = 3
b = 8
raise ArgumentError, "a must be less than b" unless a < b
result = (a + 1...b).to_a
puts "Array: #{result}"
result = (a + 1...b).to_a.reverse
puts "Array: #{result}"
puts "Array size: #{result.size}"

# 11. Дано цілочисельний масив. Знайти середнє арифметичне його елементів.

class Array
  def average
    return 0 if empty?
    sum.to_f / size
  end
end

array = [10, 20, 30, 40, 50]

average = array.average

# 12. Дано цілочисельний масив. Знайти всі парні елементи.
array = [1, 2, 3, 4, 5, 6, 7, 8, 2, 10]
validate_array(array)
even_elements = array.select { |num| num.even? }

# 13. Дано цілочисельний масив і число К. Якщо існує елемент, менший за К, то вивести true; в іншому випадку вивести false.
array = [10, 20, 30, 5, 40]
validate_array(array)
k = 15
validate_k(k)
result = array.any? { |num| num < k }

# 14. Дано цілочисельний масив і число К. Якщо всі елементи масиву менші за К, то вивести true; в іншому випадку вивести false.
array = [10, 20, 30]
validate_array(array)
k = 40
validate_k(k)
result = array.all? { |num| num < k }

# 15. Дано цілочисельний масив і число К. Вивести індекс першого елемента, більшого за К.
array = [10, 20, 30, 5, 40]
validate_array(array)
k = 25
validate_k(k)
index = array.find_index { |num| num > k }

if index.nil?
  puts "Element greater than #{k} not found."
else
  puts "Index of first element greater than #{k}: #{index} (#{array[index]})"
end

# 16. Дано цілочисельний масив. Вивести індекси елементів, менших за свого лівого сусіда, і кількість таких чисел.
array = [10, 5, 8, 12, 7, 6, 4, 15]
validate_array(array)
indices = (1...array.size).select { |i| array[i] < array[i - 1] }

puts "Indices of elements smaller than their left neighbor: #{indices}. Number of such numbers: #{indices.size}"