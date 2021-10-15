# 完全一致の検出方法
text = <<-TEXT
sounds that are pleasing to the ear.
ear is the organ of the sense of hearing.
I can't bear it.
Why on earth would anyone feel sorry for you?
TEXT

# earを単純に検索してしまうとhearingなどearを含んでいる単語も検出してしまう。
# \b は「単語の境界」を表すメタ文字（単語の境界：スペースやピリオド、ダブルクォーテーション、行頭や行末などの意味）
# \b + ear + \bという構成で、「直前と直後に単語の境界ができる"ear"という意味
puts text.scan /\bear\b/

# （）前のtだけを検出したい場合
text = <<-TEXT
  <td>
    <%= link_to I18n.t('.show'), user %>
    <%= link_to t('.edit'), edit_user_path(user) %>
  </td>
TEXT

# カッコやスペースなども単語の境界として扱われる
puts text.scan /\bt\b/

# 肯定の後読みの場合
text = <<-TEXT
type=zip; filename=users.zip; size=1024;
type=xml; filename=posts.xml; size=2048;
TEXT

puts text.scan /filename=([^;]+)/
# 肯定の後読み
# (?<=abc) は"abc"という文字列そのものではなく、その文字列の「直後の位置」（abcであればcの直後）にマッチする。
# (?<=filename=)[^;]+ は「"filename="という文字列の直後から始まって、";"以外の文字が1文字以上続く」という意味
puts text.scan /(?<=filename=)[^;]+/
# 肯定の後読みを使わない場合、'='で分割して後ろを取る、といった処理が必要になり、以下のようにする
# text.scan(/filename=[^;]+/).map { |s| s.split('=').last }

# 肯定の先読み
text = <<-TEXT
John:guitar, George:guitar, Paul:bass, Ringo:drum
Freddie:vocal, Brian:guitar, John:bass, Roger:drum
TEXT

puts text.scan /(\w+):bass/
# 肯定の先読みをした場合
# (?=abc) は"abc"という文字列そのものではなく、その文字列の「直前の位置」(abcであればaの直前)にマッチする。
# \w+(?=:bass) は「":bass"という文字列の直前にある、1文字以上続く英単語の構成文字」という意味
puts text.scan /\w+(?=:bass)/


# 否定の後読み
text = <<-TEXT
東京都
千葉県
神奈川県
埼玉都
TEXT

# (?<!abc) は"abc"という文字列以外の「直後の位置」にマッチする。
# (?<!東京)都 は「"東京"以外の文字列の直後に出てくる"都"」の意味
puts text.scan /(?<!東京)都/

# 否定の先読み
text = <<-TEXT
つぼ焼きにしたサザエはおいしい
日曜日にやってるサザエさんは面白い
TEXT

# (?!abc) は"abc"という文字列以外の「直前の位置」にマッチする。
# サザエ(?!さん) は「"さん"以外の文字列の直前に出てくる"サザエ"」の意味
puts text.scan /サザエ(?!さん)/

# 後方参照
text = <<-HTML
<a href="http://google.com">http://google.com</a>
<a href="http://yahoo.co.jp">ヤフー</a>
<a href="http://facebook.com">http://facebook.com</a>
HTML

# \1 「()でキャプチャされた1番目の文字列」を表す
puts text.scan /<a href="(.+?)">\1<\/a>/


# メタ文字の複雑な組み合わせ
text = <<-TEXT
You say yes. - @jnchito 8s
I say no. - @BarackObama 12m
You say stop. - @dhh 7h
I say go go go. - @ladygaga Feb 20
Hello, goodbye. - @BillGates 11 Apr 2015
TEXT

# (@\w+) は「"@"で始まり、任意のアルファベットが続く文字列」という意味
# (?:\d+ )? は「数字あり、またはなし」という意味
# ? 「直前の文字が1個、またはゼロ」を表すメタ文字
# ?は()の後ろに置くことで「カッコに囲まれた文字列が1個、またはゼロ」という意味になる
# (?: ) ()内に?:を入れることでキャプチャ対象外にすることができる
# (\d+[smh]) = 秒、分、時間の場合
# ((?:\d+ )?[A-Z][a-z]{2} \d+) = 1日以上前、1年以上前の場合
# ^(.*) - = ツイート
# (@\w+) = アカウント
# (\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+) = ツイート日時
puts text.gsub(/^(.*) - (@\w+) (\d+[smh]|(?:\d+ )?[A-Z][a-z]{2} \d+)/, "/1/2/3")


# 正規表現の良し悪し
# (_+|\w+)*a のように、+ や * が ( ) の中にも外にも出てくる正規表現は危険
# https://regex101.com/ :パフォーマンスの確認ツール


# その他知識
# [] や . など正規表現として意味をもつ特殊な文字を検索したい場合は、文字の前に \ (エスケープ)を入れること (例: \[ \])
# []の使い方
text = <<-TEXT
begin
  5.times { |n| puts (-10 * n + 1 / 0).zero? ^ true }
rescue
  puts $!
end
TEXT

# [()$.*+?|{}] と記載すると「"(" か ")" か "$" か・・・ "}" のいずれか1文字」の意味になる
# [] 内ではメタ文字の働きが消え、「ただの文字」になる
# puts text.scan /[()$.*+?|{}]/
# [\w\d\s\n] は「英単語を構成する文字、または半角数字、または空白文字、または改行文字のいずれか1文字」の意味になり、メタ文字としての働きを保ったままになる
# puts text.scan /[\w\d\s\n]/

# - の使い方
# [a-z] は「"a"または"b"・・・または"z"のいずれか1文字」という意味
# [-az] [az-] は「"a"または"z"または"-"のいずれか1文字」という意味
# ^ の使い方
# [^abc] は「"a"でもなく"b"でもなく"c"でもない任意の1文字」の意味
# [abc^] は「"a"または"b"または"c"または"^"のいずれか1文字」の意味

# \b は「単語の境界」という意味を表すが、[\b]と書くと、「バックスペース文字(0×08)」という意味になる

# 「n個以上」や「n個以下」を指定する
text = <<-TEXT
google
gooogle
goooogle
gooooogle
goooooogle
TEXT

# {n} は「直前の文字がn個」という意味
# {n,m} は「直前の文字がn個以上m個以下」という意味
# {n,} は「直前の文字がn個以上」という意味
# {,m} は「直前の文字がn個以下」という意味
puts text.scan /go{4,}gle/
puts text.scan /go{,3}gle/

# 大文字にすることで逆の意味になるメタ文字
text = <<-TEXT
sounds that are pleasing to the ear.
ear is the organ of the sense of hearing.
I can't bear it.
Why on earth would anyone feel sorry for you?
TEXT

# \W = 英単語の構成文字以外（記号や空白文字など）
# \D = 半角数字以外
# \S = 空白文字以外
# \B = 単語の境界以外の位置
# \B スペースやピリオドが左右にない"hearing"の"ear"がマッチする
puts text.scan /\Bear\B/


# まとめ
# \b は単語の境界を表す
# (?=abc) は「abcという文字列の直前の位置」を表す（先読み）
# (?<=abc) 「abcという文字列の直後の位置」を表す（後読み）
# (?!abc) は「abcという文字列以外の直前の位置」を表す（否定の先読み）
# (?<!abc) 「abcという文字列以外の直後の位置」を表す（否定の後読み）
# キャプチャした文字列は正規表現内でも \1 や \2 といった連番で参照できる（後方参照）
# ? や *、+ といった量指定子は ( ) の後ろに付けることもできる
# | を使ったOR条件では、各条件内でもメタ文字が使える
# 書き方によっては、とんでもなく遅い正規表現ができあがることもある
# メタ文字はバックスラッシュ（\）でエスケープする
# [ ] 内ではメタ文字の種類や使われる位置によって各文字の働きが異なる
# {n,} や {,n} はそれぞれ「直前の文字がn個以上」「n個以下」の意味になる
# \W、\S、\D、\B はそれぞれ \w、\s、\d、\b の逆の意味になる