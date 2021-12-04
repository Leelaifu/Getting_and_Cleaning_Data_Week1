# Week1 of Getting and Cleaning Data @ Coursera
 
 #1.Get/set your working directory 
    setwd()
 #2.Checking for and creating directories
    if (!file.exists("data")){
        dir.create("data")
    }
 #3.Getting data from the internet-download.file()
    fileUrl <- "https://d3c33hcgiwev3.cloudfront.net/_435617e7fe342da2865ed0c01d8a4007_01_04_downLoadingFiles.pdf?Expires=1638489600&Signature=QsVnL6FE5SAiRn~K5-qdqOS78xW6QlueqtY2ozWueWcU4jEGxxbhfsdUtEFL~w-jJJRVm9QEurYhLTdrLu-ZqJeS2vvRNTLYytrYj3clAspabeeHYxddGJ54NW6P2j2HaTraet6H3xJ8SO5KZglftp~ubyivOUkBFyWN476BmIY_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"
    download.file(fileURL, destfile = "./data/.cameras.xlsx", method = "curl")
                          #destfile:the file path where the downloaded file is to be saved.
    dateDownloaded <- date()
    dateDownloaded
 #4.Loading flat files - read.table()
    courserapdf <- read.table(".name_of_data.pdf", sep =",", header = TRUE)
    head(courserapdf) 

 #5.Reading Excel file
   #Download the file to load
    if (!file.exists("data")){dir.create("data")}
    fileUrl <- "http://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
    download.file(fileURL, destfile = "./data/.camera.xlsx", method = "curl")
   #xlsx package
    library(xlsx)
    camera.Data <- read.xlsx("./data/.cameras.xlsx", sheetIndex=1,  header=TRUE)
    head(camera.Data)                               #sheetIndex: a number representing the sheet index in the workbook.
   #Reading specific rows and columns
    colIndex <- 2:3
    rowIndex <- 1:4
    cameraDataSubset <- read.xlsx("./data/.cameras.xlsx", sheetIndex=1, colIndex = colIndex, rowIndex = rowIndex) ##read.xlsx2 is much faster than read.xlsx
  
 #6.Reading XML
   #Read the file into R 
    library(XML)
    fileUrl <- "http://www.w3schools.com/xml/sample.xml"
    doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
    rootNode <- xmlRoot(doc)
    xmlName(rootNode)
   #Directly access parts of the XML document
    rootNode[[1]]
    rootNode[[1]][[1]]
   #Programatically extrct parts of file
    xmlSapply(rootNode,xmlValue)
   #Get the items on the menu and prices
    xpathSApply(rootNode,"//name",xmlValue)
    xpathSApply(rootNode,"//price",xmlValue)
   #Extract content by attributes
    fileUrl <- "http://www.w3schools.com/xml/sample.xml"
    doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
    scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
    teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
    scores
    teams
   #Reading data from JSON(JavaScript Object Notation)
    library(jasonlite)
    jsonData <- fromJson("https://api.github.com/users/jtleek/repos")
    names(jsonData)
    #nested objects in JSON
    names(jsonData$owner)
    jsonData$owner$login
    #writing data frames to JSON
    myjson <- toJson(iris, pretty = TRUE)
    cat(myjson)
    #convert back to JSON
    iris2 <- fromJSON(myjson)
    head(iris2)
    
 #7.The data.table Package
   #creat data tables just like data frames
    library(data.table)
    DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
    head(DF,3)
    DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
    head(DT,3)
   #see all the data tables in memory
    tables()
   #subsetting rows
    DT[2,]
    DT[DT$y=="2",]
    DT[c(2,3)]
   #subsetting columns!?
    DT[,c(2,3)]
  
 #8.Column subsetting in data.table
    {
        x = 1
        y = 2
    }
    k = {print(10); 5} #the argument passed after comma call an "expression"
    print(k)           #in R an expression is a collection of statements enclosed in curley brackets
    #calculating values for variables with expressions
    DT[,list(mean(x),sum(z))]
    DT[,table(y)]
    #adding new columns
    DT[,w:=z^2]
    DT2 <- DT
    DT[,y:= 2]
    head(DT,n=3)
    head(DT2,n=3) #be careful
    #multiple operations 
    DT[,m:= {tmp <- (x+z); log2(tmp+5)}] 
    #plyr like operations 
    DT[,a:=x>0]
    DT[,b:= mean(x+w),by=a]
    #Special variables
    set.seed(123) #"N", An integer, length 1, containing the number
    DT <- data.table(x=sample(x=letters[1:3], 1E5, TRUE))
    DT[, .N, by=x]
    #Keys
    DT <- data.table(x=rep(c("a","b","c"), each=100), y=rnorm(300))
    setkey(DT,x)
    DT['a']
    #Joins
    DT1 <- data.table(x=c('a','a','b','dt1'), y=1:4)
    DT2 <- data.table(x=c('a','b','dt2'), Z=5:7)
    setkey(DT1,x) ; setkey(DT2,x)
    merge(DT1, DT2)
    
 #9.Fast reading
    big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
    file <- tempfile()
    write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE)
    system.time(fread(file))
    
    system.time(read.table(file, header = TRUE, sep = "\t"))
    
#Quiz
 getwd()
 setwd("C:/Users/88695/Documents/Coursera/Getting and Cleaning Data/week1")
 URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
 
 download.file(URL,destfile = "./week1/cameras.csv")
 
 sum(!is.na(dataQuestion1$VAL) & dataQuestion1$VAL==24) 
 
 require(xlsx) 
 download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile = "quiz1data2.xlsx")
 row <- 18:23
 col <- 7:15
 dat <- read.xlsx("quiz1data2.xlsx", sheetIndex = 1, colIndex = col, rowIndex = row, header = TRUE)
 head(dat)
 
 
 
 #Q3   
 library(XML)
 URL<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
 doc <- xmlTreeParse(URL, useInternal = TRUE)
 rootNode <- xmlRoot(doc)
 xmlName(rootNode)
 zips <- xpathSApply(rootNode, "//zipcode", xmlValue)
 
 length(zips[which(zips=="21231")])    
  
 
 fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
 download.file(fileUrl4, destfile = "./Dataset/Quiz1-05.csv", method = "curl")  
 