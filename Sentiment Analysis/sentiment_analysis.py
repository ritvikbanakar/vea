import requests
import pyjq
from textblob import TextBlob
import pyfireconnect
from collections import OrderedDict

config = {
  "apiKey": "AIzaSyCjA4Fzn0itoxHLpKhMqyAUgAk25wTrt3A",
  "authDomain": "data-aa85e.firebaseapp.com",
  "databaseURL": "https://data-aa85e.firebaseio.com/",
  "storageBucket": "data-aa85e.appspot.com"

}
key = ""

url =  'https://api.nytimes.com/svc/archive/v1/2020/5.json?api-key='+key
jq_query = f'.response .docs [] | {{the_snippet: .snippet, the_headline: .headline .main, the_date: .pub_date, the_news_desk: .news_desk, the_url: .web_url, image_url: .multimedia[0] .url}}'
firebase = pyfireconnect.initialize(config)
db = firebase.database()




r= requests.get(url)
json_data = r.json()




output = pyjq.all(jq_query, json_data)
print(output[0])



for x in range(0, 10000):
	text = output[x]['the_snippet'] + output[x]['the_headline'] 
	if output[x]['image_url'] is not None:
		output[x]['image_url'] = "https://nytimes.com/" + output[x]['image_url']
	sentiment = TextBlob(text).sentiment.polarity
	output[x]['sentiment'] = sentiment
		
	if(sentiment > 0.7):
		db.child("articles").push(output[x])






