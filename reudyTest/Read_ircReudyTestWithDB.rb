# データベースの内容を取ってくるプログラム

# TODO: datファイル作る
# TODO: cinchBot.rb参考にしながら新規の投稿だけ取る

require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'root', :database => 'reudy_test')
while true
  client.query('SELECT id, name, text FROM ircReudyTestWithDB').each do |data|
    # p id,name,text
    puts "id: #{data['id']}, name:#{data['name']}, text:#{data['text']}" 
  end
  puts 'ここまで'
  sleep 5
end

# val1 = 123
# val2 = client.escape('abc')
# client.query("INSERT INTO tblname (col1,col2) VALUES (#{val1},'#{val2}')")