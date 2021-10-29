# モジュールに特異メソッドを定義
# インスタンスが作れないため、newする必要がない「単なるメソッド（関数）の集まり」を作りたいケースに向いている
module Loggable
  # モジュールに定数を定義できる
  PREFIX = '[LOG]'.freeze
  # 特異メソッドとしてメソッドを定義
  def self.log(text)
    puts "#{PREFIX} #{text}"
  end
  # 特異メソッドをたくさん定義したい場合
  # class << self
  #   def log(text)
  #   end
  # end
end
# 他のクラスにミックスインしなくてもモジュール単体でそのメソッドを呼び出せる
Loggable.log('Hello.')
# 定数を参照する
puts Loggable::PREFIX


# ミックスインでも、モジュールの特異メソッドでも使えるモジュール
# module_function
module Test
  # module_functionを引数なしで定義した場合、そこから下に記載されているメソッドが全てモジュール関数になる
  # module_function
  # 下の module_function :test を消す
  def test(text)
    puts "[TEST] #{text}"
  end
  # testメソッドをミックスインしても、モジュールの特異メソッドとしても使えるようにする
  module_function :test
end
# モジュールの特異メソッドとしてtestメソッドを呼び出す
Test.test('Hello.')
# Testモジュールをincludeしたクラスを定義する
class Item
  include Test

  def title
    # includeしたTestモジュールのtestメソッドを呼び出す
    test 'title is called.'
    'A great movie'
  end
end
# ミックスインとしてtestメソッドを呼び出す
item = Item.new
item.title


# モジュールでクラスインスタンス変数を使って、クラス自身にデータを保持する方法
module AwesomeApi
  # 設定値を保持するクラスインスタンス変数を用意する
  @base_url = ''
  @debug_mode = false

  # クラスインスタンス変数を読み書きするための特異メソッド
  class << self
    def base_url=(value)
      @base_url = value
    end

    def base_url
      @base_url
    end

    def debug_mode=(value)
      @debug_mode = value
    end

    def debug_mode
      @debug_mode
    end

    # 上ではわかりやすくするために明示的にメソッドを定義しましたが、本来は以下の一行ですむ
    # attr_accessor :base_uer, :debug_mode
  end
end
# 設定値を保存する
AwesomeApi.base_url = 'http://example.com'
AwesomeApi.debug_mode = true
# 設定値を参照する
puts AwesomeApi.base_url
puts AwesomeApi.debug_mode