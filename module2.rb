module Taggable
  def price_tag
    # priceメソッドはinclude先で定義されている
    # self.priceでも良い
    puts "#{price}円"
  end
end

class Item
  include Taggable
  def price
    1000
  end
end
item = Item.new
item.price_tag


# Comparableモジュールと<=>演算子
# Comparableモジュールは比較演算を可能する（値の大小を比較できる）
class Tempo
  include Comparable

  # bpmはBeats Per Minuteの略で音楽の速さを表す単位
  attr_reader :bpm

  def initialize(bpm)
    @bpm = bpm
  end

  # <=>はComparableモジュールで使われる演算子（メソッド）
  def <=>(other)
    if other.is_a?(Tempo)
      # bpm同士を<=>で比較した結果を返す
      bpm <=> other.bpm
    else
      # 比較できない場合はnilを返す
      nil
    end
  end

  def inspect
    "#{bpm}bpm"
  end
end
t_120 = Tempo.new(120)
t_180 = Tempo.new(180)
t_60 = Tempo.new(60)

puts t_120 > t_180
puts t_120 <= t_180
puts t_120 == t_180
tempos = [t_120, t_180, t_60]
puts tempos.sort


# オブジェクトに直接ミックスインする
module Loggable
  def log(text)
    puts "[LOG] #{text}"
  end
end
s = 'abc'
# 文字列は通常logメソッドを持たない
# s.log('Hello.') => NoMethodError: undefined method
# 文字列sにLoggableモジュールのモジュールを特異メソッドとしてミックスイン
s.extend(Loggable)
# Loggableモジュールのlogメソッドが呼び出せる
s.log('Hello.')


# 名前の衝突を防ぐ
module Baseball
  # これはBaseballモジュールに属するSecondクラス
  class Second
    def initialize(player, uniform_number)
      @player = player
      @uniform_number = uniform_number
    end

    def info
      puts "#{@player}: #{@uniform_number}"
    end
  end
end
module Clock
  # これはClockモジュールに属するSecondクラス
  class Second
    def initialize(digits)
      @digits = digits
    end

    def seconds
      puts "#{@digits}秒"
    end
  end
end
# 二塁手のAliceを作成する
alice = Baseball::Second.new('Alice', 13)
alice.info
# 時計の13秒を作成する
time = Clock::Second.new(13)
time.seconds