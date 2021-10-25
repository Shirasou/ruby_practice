class User
end
user = User.new
# Objectクラスを継承しているため、中身が空でもメソッドを呼び出すことができる
puts user.to_s
puts user.nil?
# UserクラスがObjectクラスを継承しているため
puts User.superclass

# オブジェクトのクラスを確認
puts user.class
# instance_of? メソッドを使って調べることができる
# 全く同じでないとtrueにならない
puts 'instance_of?を使用する場合'
puts user.instance_of?(User)
puts user.instance_of?(String)

# is_a? メソッドを使えばis_a関係を調べることができる
puts 'is_a?を使用する場合'
puts user.is_a?(User)
puts user.is_a?(Object)
puts user.is_a?(BasicObject)
puts user.is_a?(String)


class Product
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name: #{name}, price: #{price}"
  end

  def self.hello
    'hello'
  end
end
# DVDクラスはProductクラスを継承する
class DVD < Product
  # nameとpriceはスーパークラスでattr_readerが設定されているため不定義
  attr_reader :running_time

  def initialize(name, price, running_time)
    # スーパークラスにも存在している属性
    # @name = name
    # @price = price
    # super スーパークラスの同名メソッドを呼び出すことができる
    # スーパークラスのinitializeメソッドを呼び出す
    super(name, price)
    # DVDクラス独自の属性
    @running_time =running_time
  end

  def to_s
    # superでスーパークラスのto_sメソッドを呼び出す
    "#{super}, running_time: #{running_time}"
  end
end
dvd = DVD.new('A great movie', 1000, 120)
puts dvd.name
puts dvd.price
puts dvd.running_time

product = Product.new('A great movie', 1000)
puts product.to_s
dvd = DVD.new('An awesome file', 1000, 120)
puts dvd.to_s
# クラスを継承するとクラスメソッドも継承される
puts DVD.hello