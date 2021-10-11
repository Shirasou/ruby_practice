def to_hex(r, g, b)
  [r, g, b].inject("#") do |hex, n|
    hex + n.to_s(16).rjust(2, "0")
  end
end

def to_ints(hex)
  # r = hex[1..2]
  # g = hex[3..4]
  # b = hex[5..6]
  # ints = [r,g,b].map { |s| s.hex }
  # ints
  # リファクタリング
  hex.scan(/\w\w/).map(&:hex)
  # scanメソッドを使用
  # ブロックに代わり&:メソッド名を使用し簡易化
end
