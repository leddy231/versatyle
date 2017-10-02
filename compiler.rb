require 'json'

ROOT = File.dirname(__FILE__) + "/files/"
DEST = File.dirname(__FILE__) + "/compiled/"
def openFile(path)
	content = ''
	File.open(ROOT + path, "rb") do |file|
		content = file.read
	end
	return content
end

def buildHtml(html)
	html += ".html"
	index = openFile("index.html")
	content = openFile(html)
	index.gsub!("CONTENT", content)
	return index
end

def buildCardList(html, json)
	html = buildHtml(html)
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

def save(html, name)
	File.open(DEST + name, "wb") {|f| f.write(html)}
end

save(buildCardList("projects", "projects.json"), "projects.html")
save(buildCardList("team", "team.json"), "team.html")
save(buildHtml("home"), "home.html")
save(buildHtml("contact"), "contact.html")
