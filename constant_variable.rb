# constant
class Item
  DEFAULT_PRICE = 0
  # private_constant :DEFAULT_PRICE で外部から参照できないようにすることができる
  # 定数はクラス構文直下で作成すること（メソッドの内部で定数を作成するとエラーになるため）
  # freeze で再導入を防ぐことができる（ほとんど使用しない）
  # 再代入して定数の値を書き換える
  DEFAULT_PRICE = 1000
end
puts Item::DEFAULT_PRICE
# クラスの外部からでも再導入が可能
Item::DEFAULT_PRICE = 3000
puts Item::DEFAULT_PRICE
# クラスを凍結させることで再代入を防ぐことができる(普通は使用しない)
# Item.freeze
# Item::DEFAULT_PRICE = 5000

class Product
  NAME = 'A product'
  # 各要素をfreezeさせることで破壊的な変更を阻止できる
  # 数値やシンボル、true/falseはfreeze不要（イミュータブルなオブジェクトなため）
  # 以下をmapを使ってリファクタリングする SOME_NAMES = ['Foo'.freeze, 'Bar'.freeze, 'Baz'.freeze].freeze
  SOME_NAMES = ['Foo', 'Bar', 'Baz'].map(&:freeze).freeze
  SOME_PRICES = { 'Foo' => 1000, 'Bar' => 2000, 'Baz' => 3000}
  def self.names_without_foo(names = SOME_NAMES)
    # namesがデフォルト値だと、以下のコードは定数のSOME_NAMEを破壊的に変更している事になる
    names.delete('Foo')
    names
  end
end
# 文字列を破壊的に大文字に変換
# Product::NAME.upcase! <= can't modify frozen Array
# Product.names_without_foo <= can't modify frozen Array
# 配列に新しい要素を追加する
# Product::SOME_NAMES << 'Hoge'
# puts Product::SOME_NAMES
# ハッシュに新しいキーと値を追加する
Product::SOME_PRICES['Hoge'] = 4000
puts Product::SOME_PRICES


# variable
# class instance variable
class Product
  # クラスインスタンス変数：クラスをインスタンス化（クラス名.newでオブジェクトを作成）した際、オブジェクトごとに管理させる変数
  @name = 'Product'
  def self.name
    # クラスインスタンス変数
    @name
  end

  def initialize(name)
    # インスタンス変数：インスタンス作成とは無関係に、クラス自信が保持しているデータ（クラス自身のインスタンス変数）です。クラス構文の直下や、クラスメソッドの内部で＠で始まる変数を操作するとクラスインスタンス変数にアクセスしていることになる。
    @name = name
  end

  # attr_reader :nameでもいいが、@nameの中身を意識するためにあえてメソッドを定義する
  def name
    # インスタンス変数
    @name
  end
end
# puts Product.name => Product
product = Product.new('A great movie')
# puts product.name => A great movie
# puts Product.name => Product
class DVD < Product
  @name = 'DVD'
  def self.name
    # クラスインスタンス変数を参照
    @name
  end

  def upcase_name
    # インスタンス変数を参照
    @name.upcase
  end
end
puts Product.name
# => Product
puts DVD.name
# => DVD

product = Product.new('A great movie')
puts product.name
# => A great movie

dvd = DVD.new('An awesome file')
puts dvd.name
# => An awesome file
puts dvd.upcase_name
# => AN AWESOME FILE

puts Product.name
# => Product
puts DVD.name
# => DVD


# class variable
# クラス変数：クラスメソッド内でもインスタンスメソッド内でも共有され、なおかつスーパークラスとサブクラスでも共有される変数
# クラスメソッド：@@name


# global variable
# グローバル変数：＄で変数名を始める。クラスの内部、外部を問わず、プログラムのどこからでも変更、参照が可能。

# グローバル変数の宣言と値の代入
$program_name = 'Awesome program'
# グローバル変数に依存するクラス
class Program
  def initialize(name)
    $program_name = name
  end

  def self.name
    $program_name
  end

  def name
    $program_name
  end
end
puts Program.name
program = Program.new('Super program')
puts program.name
puts Program.name
puts $program_name