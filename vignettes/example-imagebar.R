library(patternplot)
library(jpeg)

#http://all-free-download.com/free-vector/modern-seamless-pattern.html
childcare<-readJPEG(system.file("img", "childcare.jpg", package="patternplot"))
food<-readJPEG(system.file("img", "food.jpg", package="patternplot"))
housing <-readJPEG(system.file("img", "housing.jpg", package="patternplot"))

#Example 1
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
data<-data[which(data$City=='City 1'),]
x<-factor(data$Type_of_Expenses, c('Housing', 'Food',  'Childcare'))
y<-data$Monthly_Expenses
pattern.type<-list(housing, food, childcare)
imagebar(data,x, y,group=NULL,pattern.type=pattern.type, 
         frame.color=c('darkred', 'darkgreen', 'orange'),
         ylab='Monthly Expenses, Dollars')
