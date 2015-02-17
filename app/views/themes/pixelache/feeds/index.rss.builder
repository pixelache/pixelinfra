#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Pixelache"
    xml.author "Pixelache Helsinki"
    xml.description "News and events from Pixelache Helsinki"
    xml.link "https://www.pixelache.ac"
    xml.language "en"

    for article in @feed
      xml.item do
        if article.item.class == Event
          xml.title article.item.name
          xml.author "office@pixelache.ac"
          xml.link "http://pixelache.ac" + event_path(article.item)
          xml.guid "http://pixelache.ac" + event_path(article.item)
        else
          xml.title article.item.title
          xml.author article.item.creator.email + " #{article.item.creator.name})"
          xml.link "http://pixelache.ac" + post_path(article.item)
          xml.guid "http://pixelache.ac" + post_path(article.item)
        end
        xml.pubDate article.fed_at.to_s(:rfc822)

        text = article.item.body
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.
        if article.item.image?
            image_url = article.item.image.url(:standard)
            image_tag = "
                <p><img src='" + image_url +  "' /></p>
              "
            text = image_tag + text
        end
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end