# 名前付きキャプチャ
text = '2016-05-08'

# (?<name>pattern) ?< > の中に入る文字列がキャプチャの名前
puts text.gsub(
  /(?<year>\d+)-(?<month>\d+)-(?<day>\d+)/, 
  '\k<year>年\k<month>月\k<day>日'
)

# 名前付きキャプチャを変数に入れる
s = '2016-05-08'
if m = s.match(/(?<year>\d+)-(?<month>\d+)-(?<day>\d+)/)
  year  = m[:year]
  month = m[:month]
  day   = m[:day]
  puts "year: #{year}, month: #{month}, day: #{day}"
  # => year: 2016, month: 05, day: 08
end

# /正規表現リテラル/ =~ 文字列 とすることで名前付きキャプチャを直接ローカル変数にアサインできる
s = '2016-05-08'
if /(?<year>\d+)-(?<month>\d+)-(?<day>\d+)/ =~ s
  # 名前付きキャプチャがそのままローカル変数になる
  puts "year: #{year}, month: #{month}, day: #{day}"
  # => year: 2016, month: 05, day: 08
end

# 名前付きを使用しない場合
s = '2016-05-08'
if m = s.match(/(\d+)-(\d+)-(\d+)/)
  year  = m[1]
  month = m[2]
  day   = m[3]
  puts "year: #{year}, month: #{month}, day: #{day}"
  # => year: 2016, month: 05, day: 08
end


# 後方参照で名前付きキャプチャ
# HTMLからhrefのURLと表示テキストの内容が全く一緒のリンク（aタグ）を抜き出す
html = '<p>Please visit <a href="http://google.com">http://google.com</a>.</p>'

# 正規表現で該当するリンクを抜き出す。\1が連番で後方参照されている部分
puts html[/<a href="(.+?)">\1<\/a>/]
# => <a href="http://google.com">http://google.com</a>

# 名前付きキャプチャを使用した場合
html = '<p>Please visit <a href="http://google.com">http://google.com</a>.</p>'

# 名前付きキャプチャと後方参照を組み合わせる
puts html[/<a href="(?<url>.+?)">\k<url><\/a>/]
# => <a href="http://google.com">http://google.com</a>