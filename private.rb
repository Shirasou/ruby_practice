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
end
# クラスメソッドはprivateメソッドにならない
puts User.hello
puts User.hi