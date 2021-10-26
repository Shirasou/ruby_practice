s = 'Hello'
# sizeとlenghtはエイリアスメソッド
puts s.size
puts s.length


# エイリアスメソッドの定義
class User
  def hello
    'Hello!'
  end

  # helloメソッドのエイリアスメソッドとしてgreetingを定義する
  alias greeting hello
end
user = User.new
puts user.hello
puts user.greeting


# メソッドの削除
class User
  # freezeメソッドを削除する
  undef freeze
end
user = User.new
# user.freeze <= NoMethodError: undefined method


# ネストしたクラスの定義
class User
  class BloodType
    attr_reader :type

    def initialize(type)
      @type = type
    end
  end
end
blood_type = User::BloodType.new('B')
puts blood_type.type


# 演算子の挙動を独自に再定義する
class Public
  # =で終わるメソッドを定義する
  def name=(value)
    @name = value
  end
end
public = Public.new
# 変数に代入するような形式でname=メソッドを呼び出せる
puts public.name = 'Alice'

class Product
  attr_reader :code, :name

  def initialize(code, name)
    @code = code
    @name = name
  end

  def ==(other)
    if other.is_a?(Product)
      # 商品コードが一致すれば同じProductと見なす
      code == other.code
    else
      false
    end
  end
end
a = Product.new('A-0001', 'A great movie')
b = Product.new('B-0001', 'An awesome file')
c = Product.new('A-0001', 'A great movie')

puts a == b
puts a == c