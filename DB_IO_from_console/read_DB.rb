# データベースの内容を取ってくるプログラム

# TODO: datファイル作る
# TODO: cinchBot.rb参考にしながら新規の投稿だけ取る

require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'root', :database => 'reudy_test')
while true
  client.query('SELECT TML_ID, USR_ID, MESSAGE FROM T_TIME_LINE').each do |data|
    # p id,name,text
    puts "TML_ID: #{data['TML_ID']}, USR_ID:#{data['USR_ID']}, MESSAGE:#{data['MESSAGE']}"
  end
  puts 'ここまで'
  sleep 5
end

# val1 = 123
# val2 = client.escape('abc')
# client.query("INSERT INTO tblname (col1,col2) VALUES (#{val1},'#{val2}')")