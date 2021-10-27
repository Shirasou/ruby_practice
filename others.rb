# 等値を判断するメソッドや演算子
# equal?：全く同じインスタンスか判断する場合に使用する。メソッドの再定義はしてはいけない
# (object_idが等しい場合にtrue)
a = 'abc'
b = 'abc'
puts a.equal?(b)
c = a
puts a.equal?(c)

# ==：オブジェクトの内容が正しいか判断する。人間の目で見て自然であればtrue（例：1 = 1.0）
puts 1 == 1.0

# eql?：ハッシュのキーとして２つのオブジェクトが等しいかどうか判断する。
a = 'japan'
b = 'japan'
# eql?が真なら、hash値も同じ
puts a.eql?(b)
puts a.hash
puts b.hash
c = 1
d = 1.0
# eql?が偽なら、hash値も異なる
puts c.eql?(d)
puts c.hash
puts d.hash

# ===：主にcase文のwhen節で使われる。
text = '03-1234-5678'
case text
when /\d{3}-\d{4}/
  puts '郵便番号です'
when /\d{4}\/\d{1,2}\/\d{1,2}$/
  puts '日付です'
when /^\d+-\d+-\d+$/
  puts '電話番号です'
end
# 内部的には /^\d{3}\d{4}/ === text という処理になる

# オープンクラスとモンキーパンチ
# Rubyのクラスは変更に対してオープンなので、「オープンクラス」と呼ばれることがある。
# Stringクラスを継承した独自クラスを定義する
class String
  # Stringクラスを拡張するためのコードを書く
  def shuffle
    chars.shuffle.join
  end
end
s = 'Hello, I am Alice.'
puts s.shuffle

# モンキーパンチ：既存のメソッドを上書きして、自分の期待する挙動に変更すること
# 以下のUserクラスは外部ライブラリで定着されている想定
class User
  def initialize(name)
    @name = name
  end

  def hello
    "Hello, #{@name}!"
  end
end
# 挙動を確認
user = User.new('Alice')
puts user.hello
# helloメソッドにモンキーパンチをあてて独自の挙動を持たせる
class User
  # 既存のhelloメソッドはhello_originalとして呼び出せるようにしておく
  alias hello_original hello
  # helloメソッドにモンキーパンチをあてる
  def hello
    "#{hello_original}じゃなくて、#{@name}さん、こんにちは！"
  end
end
# helloメソッドの挙動が変わっている
puts user.hello

# 特異メソッド
alice = 'I am Alice.'
bob = 'I am Bob'
# aliceのオブジェクトにだけ、shuffleメソッドを定着する
def alice.shuffle
  chars.shuffle.join
end
# aliceはシャッフルメソッドをもつが、bobは定義していない
puts alice.shuffle
# puts bob.shuffle <= NoMethodError: undefined method
# 数値とシンボルだけはRubyの実装上の制約により、特異メソッドを定義できない
# 下記の記述でも定義可能
class << bob
  def shuffle
    chars.shuffle.join
  end
end
puts bob.shuffle