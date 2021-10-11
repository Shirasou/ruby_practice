puts "計算をはじめます"
puts "何回計算を繰り返しますか？"
a = gets.to_i
i = 1
while i <= a do
  puts "#{i}回目の計算"
  puts "2つの値を入力してください"

  b = gets.to_i
  c = gets.to_i

  puts "b = #{b}"
  puts "c = #{c}"

  puts "計算結果を出力します"
  puts b + c
  puts b - c
  puts b * c
  puts b / c

  i += 1
end

puts "計算を終了します"