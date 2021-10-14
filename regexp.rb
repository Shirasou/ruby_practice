# 電話番号の検索
text = <<TEXT
名前：伊藤淳一
電話：01-1234-5678
住所：兵庫県西脇市板波町1-2-3
TEXT

# \dは「1個の半角数字」を意味するメタ文字
puts text.scan /\d\d-\d\d\d\d-\d\d\d\d/

# 市街局番等への対応
text = <<TEXT
名前：伊藤淳一
電話：02-1234-5678
電話：090-1234-5678
電話：0795-12-3456
電話：04992-1-2345
住所：兵庫県西脇市板波町1-2-3
TEXT

# {n,m}と{n}は量指定子と呼ばれる。文字数を指定するメタ文字。
# {n,m}は「直前の文字がn個以上、m個以下」という意味
# {n}は「ちょうどn字」という意味
puts text.scan /\d{2,5}-\d{1,4}-\d{4}/

# ハイフンやカッコへの対応
text = <<-TEXT
名前：伊藤淳一
電話：03(1234)5678
電話：090-1234-5678
電話：0795(12)3456
電話：04992-1-2345
住所：兵庫県西脇市板波町1-2-3
TEXT

# [AB]は「AまたはBのいずれ1文字」という意味（[ABC]と複数記載することが可能で文字制限はない）
# []中のハイフンの位置によっては「文字の範囲」という意味になってしまう。例：[a-b]=>aまたはb
numbers = text.scan /0[1-9]\d{0,3}[-(]\d{1,4}[-)]\d{4}/
puts numbers.grep(/\(\d+\)|-\d+-/)