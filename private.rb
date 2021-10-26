# メソッドの公開レベル

# publicメソッド
# publicメソッドはクラスの外部からでも自由に呼び出せるメソッドおる。
# initializeメソッド以外のインスタンスメソッドはデフォルトでpublicメソッドになる。
class Product
  def hello
    # privateのメソッドにselfをつけるとレシーバを指定してメソッドを呼び出すため、エラーになる
    puts "Hello!, I am #{name}"
  end

  def to_s
    puts "name: #{name}"
  end

  private

  def name
    'A great movie'
  end

  def my_name
    name
  end
end
# privateメソッドはサブクラスでも呼び出せる
class DVD < Product
  private
  def name
    'An awesome file'
  end
end
product = Product.new
product.hello
product.to_s
# product.my_name => NoMethodError
dvd = DVD.new
dvd.to_s

class User
  private
  # クラスメソッド：クラス全体に関わる情報を変更したり参照したりするメソッドを作成する時に使用する
  # 個別のインスタンスに関わる情報を変更したり参照したりするメソッドを作成する時に使う
  def self.hello
    'Hello!'
  end
  # private_class_method :hello と記載することクラスメソッドをprivateに変更できる

  # class << self の構文だとprivateが機能する
  class << self
    private
    def hi
      'Hi!'
    end
  end

  # ここから下はpublicメソッドになる
  public
  def fine
    put "Fine"
  end

  def foo
    'foo'
  end

  def bar
    'bar'
  end

  # fooとbarをprivateメソッドに変更する
  private :foo, :bar

  # bazはpublicメソッド
  def baz
    'baz'
  end
end
# クラスメソッドはprivateメソッドにならない
puts User.hello
user = User.new
# puts user.hi <= NoMethodError
puts user.baz
# puts user.foo <= NoMethodError
# puts user.bar <= NoMethodError

class Public
  # weightは外部に公開しない
  attr_reader :name

  def initialize(name,weight)
    @name = name
    @weight = weight
  end

  # 自分がother_publicより重い場合はtrue
  def heavier_than?(other_public)
    other_public.weight < @weight
  end

  # 外部には公開したくないが、同じクラスやサブクラスの中であればレシーバ付きで呼び出せるようにしたい場合に、protectedを使う
  protected
  # protectedメソッドなので同じクラスがサブクラスであればレシーバ付きで呼び出せる
  def weight
    @weight
  end
end
alice = Public.new('Alice', 50)
bob = Public.new('Bob', 60)
puts alice.heavier_than?(bob)
puts bob.heavier_than?(alice)
# alice.weight <= NoMethodError