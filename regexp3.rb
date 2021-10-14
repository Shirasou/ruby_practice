# スペース文字やタブ文字の入った空行を見つける
text = <<-TEXT
  def hello(name)
    puts "Hello, \#{name}!"
  end

  hello('Alice')
              
  hello('Bob')
      
  hello('Carol')
TEXT

# ^[ \t]+$ で空行に含まれるスペースだけ検出できる
# \t はタブ文字を表すメタ文字
# ^ は「行頭」を表すメタ文字（アンカー：マッチした位置を表すメタ文字）
# $ は「行末」を表すメタ文字
# ^ +$ は「行頭から行末までスペースが1文字以上続く」という意味
# [ \t]+$ でも可能
puts text.gsub(/^[ \t]+$/, "")

text = <<-TEXT
  def hello(name)   
    puts "Hello, \#{name}!"
  end      
TEXT

puts text.gsub(/[ \t]+$/, "")

text = <<-TEXT
Lorem ipsum dolor sit amet.
Vestibulum luctus est ut mauris tempor tincidunt.
         Suspendisse eget metus
      Curabitur nec urna eget ligula accumsan congue.
TEXT

puts text.gsub(/^[ \t]+/, "")

# 不揃いなスペースを揃える
text = <<-TEXT
{
  japan:	'yen',
  america:'dollar',
  italy:     'euro'
}
TEXT

puts text.gsub(/:[ \t]*/, ": ")

# \sを使用した場合
text = <<-TEXT
{
  japan:	'yen',
  america:'dollar',
  italy:     'euro'
}
TEXT

# \sは半角スペースやタブ文字、改行文字など「目に見えない空白文字全般」を表すメタ文字
# 注意：\sは含まれる文字が言語や環境によって異なる
# Rubyの場合、半角スペース（ ）、タブ文字（\t）、改行文字（\n）、復帰文字（\r）、改ページ（\f）
# 注意：Rubyでは全角スペース（\u3000）が含まれていない
puts text.gsub(/:\s*/, ": ")

# カンマ区切りをタブ区切りへ
text = <<-TEXT
name,email
alice,alice@example.com
bob,bob@example.com
TEXT

puts text.gsub(/,/, "\t")

# ログから特定の文字を含む行を削除する
text = <<-TEXT
Feb 14 07:33:02 app/web.1:  Completed 302 Found ...
Feb 14 07:36:46 heroku/api:  Starting process ...
Feb 14 07:36:50 heroku/scheduler.7625:  Starting ...
Feb 14 07:36:50 heroku/scheduler.7625:  State ...
Feb 14 07:36:54 heroku/router:  at=info method=...
Feb 14 07:36:54 app/web.1:  Started HEAD "/" ...
Feb 14 07:36:54 app/web.1:  Completed 200 ...
TEXT

# ^.+ は「行頭から文字が1文字以上続く」を意味する
# +.$ は「行末から文字が1文字以上続く」を意味する
# ABC|DEF は「文字列ABC、または文字列DEF」というOR条件を表す。()は範囲を明確にするために使用されることが多い
# $の代わりに\nを使用することで改行文字が含まれるようになる
puts text.gsub(/^.+heroku\/(api|scheduler).+\n/, "")

# windowsの場合、改行コードが(\r\n)のため、windouws環境下では下記を使用
# ^.+heroku\/(api|scheduler).+\r?\n

# ^の使い方
text = <<-TEXT
ABCDEF
!@#$%^&*
TEXT

# [^AB]の場合、「AでもなくBでもない文字1文字」という否定条件となる
puts text.scan /[^AB]/

# [AB^]の場合、「AまたはBまたは^のいずれか1文字」という意味
puts text.scan /[AB^]/

# ^.の場合、「行頭にくる任意の1文字」という意味
puts text.scan /^./

# "^"という文字だけを検索したい場合、\^というバックスをつけてエスケープさせる
puts text.scan /\^/

# ^ は行頭を表す
# $ は行末を表す
# \t はタブ文字を表す
# \n は改行文字を表す
# \s は空白文字（スペース、タブ文字、改行文字等）を表す
# ABC|DEF は「文字列ABCまたは文字列DEF」のOR条件を表す
# 改行コードは環境によって異なる場合がある
# ^ は行頭の意味になったり、[^ ] で否定の文字クラスの意味になったりする