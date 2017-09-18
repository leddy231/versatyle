require 'sinatra'
require 'JSON'

ROOT = File.dirname(__FILE__) + "/files/"

def openFile(path)
	content = ''
	File.open(ROOT + path, "rb") do |file|
		content = file.read
	end
	return content
end

def sendHtml(html)
	html += ".html"
	index = openFile("index.html")
	content = openFile(html)
	index.gsub!("CONTENT", content)
	return index
end

def sendCardList(html, json)
	html = sendHtml(html)
	card = openFile("card.html")
	json = openFile(json)
	cards = ""
	for object in JSON.parse(json)
		c = card.dup
		c.gsub!("IMAGE", object["image"])
		c.gsub!("TEXT", object["text"])
		cards += c
	end
	html.gsub!("CONTENT", cards)
	html
end

get '/exit' do
  Process.kill('TERM', Process.pid)
end

get "/" do
	redirect to("/home")
end

get "/projects" do
	sendCardList("projects", "projects.json")
end

get "/team" do
	sendCardList("team", "team.json")
end

["/home", "/contact"].each do |path|
	html = path.dup
	html.slice!(0)
	get path do
		sendHtml(html)
	end
end

get "/*" do
	f = ROOT + params['splat'][0]
	if File.exists?(f)
		send_file f
	else
		pass
	end
end

not_found do
  status 404
  "Ya broke it"
end
