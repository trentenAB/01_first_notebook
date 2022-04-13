![Title Image](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/Disaster%20Tweets%20pic.png)
# Natural Language Processing with Disaster Tweets
*Twitter is one of the main sources of news for many people with a smartphone including in times of tragedy. This is not only due to stories from large news companies, but from individuals who are sharing news headlines or commnenting on a situation they are observing in real time. Becuase of this, relief organizations and new companies are interested in auto-monitoring Twitter to get the latest updates straight from first-hand accounts. With Machine Learning, sifting through thousands of tweets in mere seconds becomes possible. The problem is, as with all Machine Learning, machines do not understand context like humans and therefore have to be trained to do so. Becuase this is about tweets that consist of text, this is where we'll implement Natural Language Processing (NLP), the ability a machine can understand human language as it is spoken and written.*     

**Goal**: Come up with a Machine Learning model that can predict if the tweet pertains to a real disaster. 

# Data Pre-Processing
The data features:

![first look](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/FirstHead.png)

The `Location` and `ID` columns were subsequently dropped. 

The `keyword` and `text` columns were then cleaned. 

![cleaned keywords](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/keyword%20cleaning.png) 

![cleaned text](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/text%20prep.png)

# Exploratory Analysis
Being that this was strictly a Text Classification project, EDA was not necessary. The visuals made here were made for the sake of making visuals and don't hold any real analytical value.

![D vs nD counts](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/counts%20D%20vs%20nD.png)

The amount of each type of Tweet is relatively level and is not overly skewed. Therefore, further transforming of the data was not necessary past the usual normalization process.

[//]: < ![D distribution](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/Tweet%20length%20D.png)![nD dist.](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/Tweet%20length%20nD.png) >

[//]: < ![top keywords](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/common%20keyword%20bar.png) >

[//]: < ![square wc](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/square%20wc.png) >

[//]: < ![fire wc](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/fire%20wc.png) >

# Feature Engineering 
CountVectorizer and TfidVectorizer from Sklearn's Feature Extraction Text module was used for the features.

### CountVectorizer
![CountVect](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/CountVect_Features.png)

### TfidVectorizer
![TfidVect](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/TfidVect_Features.png)

# Supervised Learning
LogisticRegression outperformed RandomForest and SupportVectorMachine by a slim margin.

[//]: < ![algo scores df](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/algorithm%20scores.png) >

![algo scores graph](https://github.com/trentenAB/SpringBoard/blob/main/DisasterTweets/images/Algo_Comparison.png)
# Data
> * [Kaggle](https://www.kaggle.com/c/nlp-getting-started/data)
