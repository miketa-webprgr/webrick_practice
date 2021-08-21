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

server.mount_proc("/form_get") do |req, res|
  name = req.query['get_name']
  age = req.query['get_age']
  color = req.query['get_color']

  body = "<html><meta charset='utf-8'><body>\n"
  
  body += "#{req.query}"
  body += "<p>名前：#{name.force_encoding("utf-8")}</p>"
  body += "<p>年齢：#{age.to_s}</p>"
  body += "<p style = 'background-color:#{color.to_s}'>好きな色: #{color.to_s}</div>"

  body += "</body></html>\n"

  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end

server.mount_proc("/form_post") do |req, res|
  name = req.query['post_name']
  age = req.query['post_age']
  color = req.query['post_color']

  body = "<html><meta charset='utf-8'><body>\n"
  
  body += "#{req.query}"
  body += "<p>名前：#{name.force_encoding("utf-8")}</p>"
  body += "<p>年齢：#{age.to_s}</p>"
  body += "<p style = 'background-color:#{color.to_s}'>好きな色: #{color.to_s}</div>"

  body += "</body></html>\n"

  res.status = 200
  res['Content-Type'] = 'text/html'
  res.body = body
end


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
