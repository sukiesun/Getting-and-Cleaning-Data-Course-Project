x.test <- read.table("./test/X_test.txt", header = FALSE)
y.test <- read.table("./test/y_test.txt", header = FALSE) 
subject.test <- read.table("./test/subject_test.txt", header = FALSE) 
##2947

x.train <- read.table("./train/X_train.txt", header = FALSE)
y.train <- read.table("./train/y_train.txt", header = FALSE)
subject.train <- read.table("./train/subject_train.txt", header = FALSE)
##7352

features <- read.table("./features.txt", header = FALSE)
features[,2] <- as.character(features[,2])
##561
activity.labels <- read.table("./activity_labels.txt", header = FALSE)
##Q1
x <- rbind(x.test,x.train)
y <- rbind(y.test,y.train)
subject <- rbind(subject.test,subject.train)
mydata <- cbind(x,y,subject)
##Q2
colnames <- tolower(features[,2])
colnames2 <- gsub("-", ".", colnames)
colnames3 <- gsub("\\(", ".", colnames2)
colnames4 <- gsub("\\)",".",colnames3)
colnames5 <- gsub(",",".",colnames4)
names(mydata) <- c(colnames5,"y","subject")
mean.col <- grep("mean()",names(mydata))
std.col <- grep("std()",names(mydata))
mean.std.data <- cbind(mydata[,mean.col],mydata[,std.col],mydata[,562:563])

##Q3&Q4
names(activity.labels) <- c("no","activity")
merged.data <- merge(mean.std.data,activity.labels,by.x="y",by.y="no")
merged.data$activity <- tolower(gsub("_", ".", merged.data$activity))

##Q5
library(reshape2)
mdl <- melt(merged.data, id=c("subject","activity"))
mdw <- dcast(mdl, subject + activity ~ variable, fun.aggregate = mean)
write.table(mdw, "tidyData.txt", sep="\t")


