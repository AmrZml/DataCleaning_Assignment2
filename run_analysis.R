## set the path of the data

setwd("G:/Faculty/Courses/Data Science collection/03 Getting and Cleaning Data/HomeWork/Ass02/Data/")

# get the activity name and features name

    Features_name <- read.table(file="features.txt")
    feature_str <- as.character(Features_name [,2])
    
    Act_name <- read.table(file = "activity_labels.txt")
    names(Act_name)<- c("Act_id","Act_name")

    Data_name <- c("Sub_id",feature_str,"Act_id")

#tidy train Data

  SubjectId <- read.table(file = "./train/subject_train.txt")
  Trainset <- read.table(file = "./train/X_train.txt")
  TrainLabel <- read.table(file = "./train/y_train.txt")
  
  TrainData <- cbind(SubjectId,Trainset,TrainLabel)
  names(TrainData)<- Data_name

  
  TrainData$actName  <- Act_name[TrainData$Act_id,2]


# tidy test data

    SubjectId_test <- read.table(file = "./test/subject_test.txt")
    Testset <- read.table(file = "./test/X_test.txt")
    TestLabel <- read.table(file = "./test/y_test.txt")
    
    TestData <- cbind(SubjectId_test,Testset,TestLabel)

    names(TestData)<- Data_name

    TestData$actName  <- Act_name[TestData$Act_id,2]

# merge the traing data with test data

    ALLData <- rbind(TrainData,TestData)

    MeanStdCol <- grep("mean|std",names(ALLData))
    Nocol <- ncol(ALLData)
    SubData <- ALLData [,c(1,MeanStdCol,Nocol)]
    
#  tidy data set with the average of each variable for each activity and each subject.
    Split_Subject <- split(SubData,SubData$Sub_id)
    tidy <- c()
    for (i in seq(1:length(Split_Subject))){
      subject <- Split_Subject[[i]]
      Activity <- split(subject, s$actName)
      for (j in seq(1:length(Activity))){
        Act <- Activity[[j]]
        n<- length(Act)
        Avg <- sapply(Act[1:n-1],mean)
        
        row <- c(j,Avg)
        tidy <-rbind(tidy,row)
      }
    }
    data<-data.frame(tidy,row.names=NULL)
    data$Actname  <- Act_name[data[,1],2]
    
    write.table(data,"tidyData.txt")
      
    
