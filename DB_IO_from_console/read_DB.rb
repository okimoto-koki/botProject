# データベースの内容を取ってくるプログラム

require 'mysql2'

# DBに接続
client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'root', :database => 'reudy_test')

while true
  # 取ってきたものを表示

  client.query('SELECT TML_ID, USR_ID, MESSAGE FROM T_TIME_LINE order by TML_ID DESC LIMIT 1').each do |data|

    # 最終ツイートIDを取ってくる
    lastIDread = open('../lastID.dat', 'r')
    lastID = lastIDread.gets.to_i
    lastIDread.close
    p lastID

    # 最終ツイートIDが最新と一緒、もしくは最新ユーザIDが自分なら飛ばす
    if lastID == data['TML_ID']
      puts ('same TML_ID or my tweet')
    else

      # 上で無ければ表示
      puts "TML_ID: #{data['TML_ID']}, USR_ID:#{data['USR_ID']}, MESSAGE:#{data['MESSAGE']}"
    end

    # lastID.datを更新
    lastIDwrite = open("../lastID.dat", "w")
    lastIDwrite.puts data['TML_ID']
    lastIDwrite.close
    puts 'ここまで'

  end
  # 5秒に一回ループさせる
  sleep 5
end

# val1 = 123
# val2 = client.escape('abc')
# client.query("INSERT INTO tblname (col1,col2) VALUES (#{val1},'#{val2}')")