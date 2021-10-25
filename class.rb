class User
  attr_reader :first_name, :last_name, :age
  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def hello
    "Hello, I am #{full_name}"
  end

end

users = []
users << User.new('Alice', 'Ruby', 20)
users << User.new('Bob', 'Python', 30)

users.each do |user|
  puts "氏名: #{user.full_name}, 年齢: #{user.age}, 自己紹介: #{user.hello}"
end


# initializeメソッド
# インスタンスを初期化するために実行したい処理があれば、実装します。(外部から呼び出すことはできない)

# インスタンスメソッド クラス内部で定義したメソッドのこと(full_name のような)
# インスタンス変数 同じインスタンス（同じオブジェクト）の内部で共有される変数。（@ がつくもの）
