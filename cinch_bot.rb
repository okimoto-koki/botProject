require "cinch"
require "mysql2"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "localhost"
    c.port = 6667
    c.password = ''
    c.channels = ["#reudy"]
    c.nick = 'cinch'
    c.realname = 'cinch'
    c.user = 'cinch'
  end

  on :message, "start" do |m|
    # 抹茶固有のユーザID(reudyのID)
    @id = 4

    while true
      sleep 5
      # 最新のツイートIDとユーザIDを取ってくる
      $client.query('select TML_ID, USR_ID, MESSAGE from T_TIME_LINE order by TML_ID DESC limit 1').each do |row|

        # 前回の最終ツイートIDを取ってくる
        lastIDread = open("lastID.dat", "r")
        lastID = lastIDread.gets.to_i
        lastIDread.close

        # 最終ツイートIDが最新と一緒、もしくは最新ユーザIDが自分なら飛ばす
        if lastID == row['TML_ID'] || @id == row['USR_ID']
          puts ('same TML_ID or my tweet')
        else
          # IRCに送る
          # TODO: エンコードを変える
          m.reply row['MESSAGE']

          # datファイルを更新
          lastIDwrite = open('lastID.dat', "w")
          lastIDwrite.puts row['TML_ID']
          lastIDwrite.close
        end
      end
    end
  end
end

$client = Mysql2::Client.new(:host => 'localhost', :username => 'root', :password => 'root', :database => 'reudy_test')
bot.start