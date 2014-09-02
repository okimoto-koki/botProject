# データベースに書き込むプログラム
# 抹茶の代理みたいのもの

require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'root', :database => 'reudy_test')
puts 'name,text:'
while data = gets.chomp
  name, text = data.split(',')
  p name,text
  client.query("insert into T_TIME_LINE (USR_ID, MESSAGE) values('#{name}', '#{text}')")
  puts 'name,text:'
end