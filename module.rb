# モジュールをクラスにinclude
# include：モジュールで定義したメソッドがインスタンスメソッドとして呼び出せる
# ログ出力用のメソッドを提供するモジュール
module Loggable
  private

  def log(text)
    puts "[LOG] #{text}"
  end
end

class Product
  # 上で作ったmoduleをincludeする
  include Loggable

  def title
    # logメソッドはLoggableモジュールで定義したメソッド
    log "title is called."
    "A great movie"
  end
end

class User
  include Loggable

  def name
    log "name is called."
    "Alice"
  end
end

product = Product.new
product.title
# include?：引数で渡したモジュールがincludeされているか確認できる
puts product.class.include?(Loggable)
# included_modules：includeされているモジュールの配列が返る
puts product.class.included_modules
# ancestors：モジュールだけでなくスーパークラスの情報も配列になって返る
puts product.class.ancestors
# is_a?：直接インスタンスに対してincludeしているか確認できる（スーパークラスに該当するかも）
puts product.is_a?(Loggable)

user = User.new
user.name


# モジュールをextend
# extend：モジュールで定義したメソッドがそのクラスの特異メソッド（クラスメソッド）にすることができる
module Loggable
  def log(text)
    puts "[LOG] #{text}"
  end
end

class Product
  # Loggalbeモジュールのメソッドを特異メソッド（クラスメソッド）としてミックスインする
  extend Loggable

  def self.create_products(names)
    # logメソッドをクラスメソッド内で呼び出す
    # （つまりlogメソッド自体もクラスメソッドになっている）
    log 'cteate_products is called.'
  end
  log 'Defined Product class.'
end
# クラスメソッド経由でlogメソッドが呼び出される
Product.create_products([])
# Productクラスのクラスメソッドとして直接呼び出すことも可能
Product.log('Hello.')