# webrick.rb
require 'webrick'

server = WEBrick::HTTPServer.new({ 
  # きっとこれが最初にWebサーバーを開いたときに何のファイルを開くか示したやつ
  # デフォルトでrootディレクトリにあるindex.htmlを返すとか知らなかった
  :DocumentRoot => './',
  # これはip番号を示していて、127.0.0.1というのはローカルホストを指す特殊な番号
  :BindAddress => '127.0.0.1',
  # これはポート番号。実はwww.yahoo.co.jpをhttpでみるときは80、httpsのときは443。
  # 試しにhttps://www.yahoo.co.jp:443とアドレスバーに入力しても表示されるはず
  :Port => 8000
})

server.mount_proc("/time") do |req, res|
  name = "miketa"
  age = 32
  sabayomitai_age = 10

  body = "<html><meta charset='utf-8'><body>\n"
  body += "<p>#{Time.new}</p>"
  body += "<p>#{name.upcase}</p>"
  body += "<p>年齢："
  body += (age - sabayomitai_age).to_s
  body += "</p>"
  body += "</body></html>\n"
  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.start
