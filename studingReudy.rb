$KCODE= "EUC"
$OUT_KCODE= "UTF-8" #出力文字コード
$REUDY_DIR= "lib/reudy" if !defined?($REUDY_DIR) #スクE廛箸あE妊EトE

require "rubygems"
require "mysql"
require 'kconv'
require $REUDY_DIR+'/bot_irc_client'
require $REUDY_DIR+'/reudy'
require $REUDY_DIR+'/reudy_common'

module Gimite

  class StudingClient

    include(Gimite)

    def initialize(user)
      @user = user
      @user.client = self
      @database = Mysql.connect("localhost" , "matchauser", "matchapass", "matcha")
      @database.query("select TML_ID from T_TIME_LINE order by TML_ID DESC limit 1").each do |row|
        @newerTimelineID = row.join("").to_i
      end
      @database.query("select USR_ID from T_TIME_LINE order by TML_ID DESC limit 1").each do |row|
        @newerUserID = row.join("").to_i
      end

      lastIDfo = open("lastID.dat", "r")
      lastID = lastIDfo.gets.to_i

      if lastID == @newerTimelineID || @newerUserID == @id
        puts ("same TML_ID or my tweet")
        Kernel.exit(0)
      else
        lastIDfo.close
        lastIDfo = open("lastID.dat", "w")
        lastIDfo.puts @newerTimelineID+1
        lastIDfo.close  
      end
    end

    def study()
      line = mysqlOut
      puts line.toutf8()
      line = line.chomp().toeuc()
      if line==""
        @user.onSilent()
      elsif @yourNick
        @user.onOtherSpeak(@yourNick, line)
      elsif line=~/^(.+?) (.*)$/
        @user.onOtherSpeak($1, $2)
      else
        $stderr.print("Error\n")
      end
    end

    def mysqlOut()
      @database.query("select MESSAGE from T_TIME_LINE ORDER BY TML_ID DESC LIMIT 1").each do |row|
       return row.join("")
     end  
    end

    if ARGV.size() == 1
      client = StudingClient.new(Reudy.new(ARGV[0]))
      client.study()
    else
      $stderr.print(\
       "Usage: ruby stdio_reudy.rb ident_dir your_name\n\n" \
       +"'ident_dir' is a directory which contains setting.txt, log.txt, etc.\n")
    end
  end

end