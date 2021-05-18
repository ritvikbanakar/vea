# vea
## [![Watch the video](https://img.youtube.com/vi/71tKLRBT8PM/0.jpg)](https://youtu.be/71tKLRBT8PM)
Highlighting the good in humanity one news article at a time
## Inspiration
In a dark time, we realized that people are indulging in negative news more than ever. While it is important to know what is occurring, the constant influx of negativity is bound to reflect onto a person's mental health, influencing their daily life. The media seeks these negative stories as that is what most catches our attention, but we are diverging from the norm. We built vea in order to show some of the lesser known & more positive articles to add a smile to someone's day and have a little effect that (hopefully) lasts a long time.
## What it does
Vea pulls New York Times articles using the NYT API to look for the latest news. Upon finding an article, it then performs sentiment analysis to decide whether the article is positive or not. If it is, it uploads it onto a Firebase database where the iOS application can then grab the article and display it for the user.
## How I built it
The searching and sentient analysis was done via Python. The database was Firebase. The iOS app was written in Xcode with UIKit for the frontend. On the backend, SwiftSoup was used to scrape article content and Firebase was used to pull data from the database. 
## Challenges I ran into
Vea was especially challenging for us due to the application of concepts that we were not exposed to before MasseyHacks. We had never come in close contact to NLP (sentiment analysis) and implementing it into a python script was truly a challenge. Moreover, we were able to overcome this challenge by making use of our resources: online tools, experience, and the team itself. MasseyHacks allowed us to come out of our comfort zone and learn new technologies, beyond which was imagined in our initial stages.
## Accomplishments that I'm proud of
We are proud of how the app turned out overall and the functionality of it. Looking back, we were able to incorporate different technologies seamlessly and the way that they were interacting together was great. A functional backend along with artificial intelligence technology to make decisions in the background play together to enhance the user experience! We also are proud of the design of the app as it flows nicely and users can access all of the features quickly.

