class User
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  # メソッド内部で他のメソッドを呼ぶ場合は、selfを省略可能
  def hello
    # self なしでnameメソッドをよぶ
    puts "Hello, I am #{name}."
  end

  def hi
    # self ありでnameメソッドをよぶ
    puts "Hi, I am #{self.name}."
  end

  def my_name
    # 直接インスタンス変数の@nameにアクセスする
    puts "My name is #{@name}"
  end

  # self のつけ忘れで不具合が起きる例
  def rename_to_bob
    # self なしでnameメソッドをよぶ
    # メソッド内でセッターメソッドを呼び出す場合はselfを必ずつけること
    name = 'Bob'
  end

  def rename_to_carol
    # self ありでnameメソッドをよぶ
    self.name = 'Carol'
  end

  def rename_to_dave
    # 直接インスタンス変数を書き換える
    @name = 'Dave'
  end
end
user = User.new('Alice')
user.hello
user.hi
user.my_name

# Bobにリネイムできない
user.rename_to_bob
user.hello

# Carolにリネイム
user.rename_to_carol
user.hi

# Daveにリネイム
user.rename_to_dave
user.my_name


# クラスメソッドとクラス構文直下のself
class Foo
  # 注：このputsはクラス定義の読み込み時に呼び出される
  puts "クラス構文直下のself: #{self}"

  def self.bar
    puts "クラスメソッド内のself: #{self}"
    # self.baz はエラーになる(selfを省略しても同じ)
  end

  def baz
    puts "インスタンスメソッド内のself: #{self}"
    # self.bar はエラーになる(selfを省略しても同じ)
  end
  # クラス構文直下の場合はselfがどちらも「クラス自身」になるため、呼び出すことが可能
  self.bar
end
# 表示されるFooは「Fooクラス自身」を表している
Foo.bar
foo = Foo.new
# #<Foo:0x00007fdefa97d070> はFooクラスのインスタンスを表す
foo.baz


# クラスメソッドをインスタンスメソッドで呼び出す
class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

  # 金額を整形するクラスメソッド
  def self.format_price(price)
    "#{price}円"
  end

  def to_s
    # インスタンスメソッドからクラスメソッドを呼び出す
    # self.class.format_price(price) と記述しても同じ意味になる（self.classは「インスタンスが属しているクラス（ここではProductクラス）」を返すため）
    formatted_price = Product.format_price(price)
    puts "name: #{name}, price: #{formatted_price}"
  end
end

product = Product.new('A great movie', 1000)
product.to_s