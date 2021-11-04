module Effects
  def self.reverse
    ->(words) do
      words.split(' ').map(&:reverse).join(' ')
    end
  end

  def self.echo(rate)
    ->(words) do
      # スペースならそのまま返す
      # スペース以外ならその文字を指定された回数だけ繰り返す
      words.chars.map{ |c| c == ' ' ? c : c * rate }.join
    end
  end

  def self.loud(level)
    ->(words) do
      # スペースで分割 > 大文字変換と"!"の付与 > スペースで連結
      words.split(' ').map { |word| word.upcase + '!' * level }.join(' ')
    end
  end
end