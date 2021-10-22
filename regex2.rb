# // 以外の正規表現を使う方法

# Regexp.new の引数にパターンの文字列を渡す（Regexp.compile はエイリアスメソッド）
# /\d{3}-\d{4}/ と同じ
regexp = Regexp.new('\d{3}-\d{4}')
if '123-4567' =~ regexp
  puts "マッチしました"
else
  puts "マッチしませんでした"
end

# %rを使う方法
# /http:\/\/example\.com/ と同じ意味なる（スラッシュをエスケープする必要がない
%r!http://example\.com!
# ! でなく {} を使用する場合
%r{http://example\.com}

# // や %r の中で #{} を使うと変数の中身を展開することができる
pattern = '\d{3}-\d{4}'
if '123-4567' =~ /#{pattern}/
  puts "マッチしました"
else
  puts "マッチしませんでした"
end

# case 文を正規表現を使う
text = '03-1234-5678'

case text
when /^\d{3}-\d{4}$/
  puts "郵便番号です"
when /^0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}$/
  puts "電話番号です"
when /^\d{2,4}\/\d{1,2}\/\d{1,2}$/
  puts "日付です"
end

# 正規表現作成時に使えるオプション（/正規表現/オプション）
# i はアルファベットの大文字と小文字を無視してマッチする
if 'Hello' =~ /hello/i
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
# Regexp.new を使用する場合は、Regexp::IGNORECASEを使用する
regexp = Regexp.new('hello', Regexp::IGNORECASE)
if 'Hello' =~ regexp
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end

# m は任意の文字を表すドット(.)が改行文字にもマッチするようになる
# 失敗例
if "Hello\nBye" =~ /Hello.Bye/
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
# 成功例
if "Hello\nBye" =~ /Hello.Bye/m
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
# Regexp.new を使用する場合は、Regexp::MULTILINEを使用する
regexp = Regexp.new('Hello.Bye', Regexp::MULTILINE)
if "Hello\nBye" =~ regexp
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end

# x は空白文字（半角スペースや改行文字）が無視され、# を使って正規表現中にコメントが書けるようになる。
regexp = /
  \d{3} # 郵便番号の先頭3桁
  -     # 区切り文字のハイフン
  \d{4} # 郵便番号の末尾4桁
/x
if '123-4567' =~ regexp
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
# 空白を無視せず正規表現の一部として扱いたい場合はバックスラッシュでエスケープする。
regexp = /
  \d{3}
  \     # 半角スペースで区切る
  \d{4}
/x
if '123 4567' =~ regexp
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
# Regexp.new を使用する場合は、Regexp::EXTENDEDを使用する
pattern = <<'TEXT'
  \d{3} # 郵便番号の先頭3桁
  -     # 区切り文字のハイフン
  \d{4} # 郵便番号の末尾4桁
TEXT
regexp = Regexp.new(pattern, Regexp::EXTENDED)
if '123-4567' =~ regexp
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end

# オプションを複数使うことができる
if "HELLO\nBYE" =~ /Hello.Bye/im
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end
# Regexp.new を使う場合は | で連結する。
regexp = Regexp.new('Hello.Bye', Regexp::IGNORECASE | Regexp::MULTILINE)
if "HELLO\nBYE" =~ regexp
  puts 'マッチしました'
else
  puts 'マッチしませんでした'
end

# 組み込み変数でマッチの結果を取得する
text = '私の誕生日は1977年7月17日です'
# =~ や match を使うとマッチした結果が組み込み変数に代入される
text =~ /(\d+)年(\d+)月(\d+)日/
# Matchdataオブジェクトを取得する
puts $~
# マッチした部分を全部取得する
puts $&
# 1番~3番目のキャプチャを取得する
puts $1
puts $2
puts $3
# 最後のキャプチャ文字列を取得する
puts $+

# Regexp.last_match で結果を取得する
puts Regexp.last_match
puts Regexp.last_match(0)
puts Regexp.last_match(1)
puts Regexp.last_match(2)
puts Regexp.last_match(3)
puts Regexp.last_match(-1)