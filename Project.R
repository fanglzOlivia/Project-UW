#03.06
library(twitteR)
consumer_key <- "xmNvrzoxWXLoLLl7w0gwczeQv"
consumer_secret <- "DsIllyU1N2dU3hxI1bhfDdQEbN3ztWtgrjrpsvXNXMlcYQJYgt"
access_token <- "761037877-KhJEMw3e91UpujULYE9gzuzT3jPQbNvhIOKOpxdp"
access_secret <- "hMyTfYFtcKYhKnvMQkvwRw0Yjg8JfvJlaJspXb1Gzh16d"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#import data
rdmTweets <- searchTwitter('#proana', n=100) #I first set up sample size to be 100 (the first time I enter n = 500, but result shows it only return value = 320)
rdmTweets #here are data I collect from Twitter with hashtag #proana

#Create a dataframe based around the results
df <- do.call("rbind", lapply(rdmTweets, as.data.frame))
#Here are the columns
names(df)
#And some example content
head(df,1)

counts=table(df$screenName)
barplot(counts)
# Limit the data set to show only folk who tweeted twice or more in the sample
cc=subset(counts,counts>1)
barplot(cc,las=2,cex.names =0.5)



#now try to collect other related data
rdmTweets2 <- searchTwitter('#ACL', n=100)
rdmTweets2
#Create a dataframe based around the results
df2 <- do.call("rbind", lapply(rdmTweets2, as.data.frame))
#Here are the columns
names(df2)
#And some example content
head(df2,1)

counts2=table(df2$screenName)
barplot(counts2)
# Limit the data set to show only folk who tweeted twice or more in the sample
cc2=subset(counts2,counts2>1)
barplot(cc2,las=2,cex.names =0.5)


rdmTweets3 <- searchTwitter('#Type1Diabetes', n=100)
rdmTweets3

#Create a dataframe based around the results
df3 <- do.call("rbind", lapply(rdmTweets3, as.data.frame))
#Here are the columns
names(df3)
#And some example content
head(df3,1)

counts3=table(df3$screenName)
barplot(counts3)
# Limit the data set to show only folk who tweeted twice or more in the sample
cc3=subset(counts3,counts3>1)
barplot(cc3,las=2,cex.names =0.5)

#03.28
#first I use twitter R package to collect pilot data from twitter
rdmTweets4 <- searchTwitter('#pilot', n=100)
rdmTweets4

#Create a dataframe based around the results
df4 <- do.call("rbind", lapply(rdmTweets4, as.data.frame))
#Here are the columns
names(df4)
#And some example content
head(df4,1)

#04.02
write.csv(df4, "pilot.csv", row.names=F)
pilot <- read.csv("pilot.csv",header=FALSE,stringsAsFactors=FALSE)
pilot
#convert to matrix format
pilot <- as.matrix(pilot) 

#create a network object
library(network)
Datapilot<-network(pilot,directed=FALSE)
Datapilot
#description using network
summary(Datapilot) #the overall summary--network attributes
network.dyadcount(Datapilot) #number of dyads
network.edgecount(Datapilot) #number of edge
network.size(Datapilot) #size of the network
as.sociomatrix(Datapilot) #convert as a sociomatrix

library(sna)
gplot(Datapilot)  
gden(Datapilot) #network density

