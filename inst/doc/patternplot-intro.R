## ----setup, include=FALSE------------------------------------------------
library(knitr)
library(Cairo)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center", dev='CairoPNG')
options(warn=-1)

## ----e1, fig.height = 6, fig.width = 10----------------------------------
library(patternplot)
library(png)
library(ggplot2)
data <- read.csv(system.file("extdata", "vegetables.csv", package="patternplot"))
#Example 1
pattern.type<-c('hdashes', 'vdashes', 'bricks')
pie1<-patternpie(group=data$group,pct=data$pct,label=data$label, 
                 label.size=4, label.color='black',label.distance=1.3,pattern.type=pattern.type,
           pattern.line.size=c(10, 10, 2), frame.color='black',frame.size=1.5, pixel=12, density=c(8, 8, 10))
pie1<-pie1+ggtitle('(A) Black and White with Patterns')
#Example 2
pattern.color<-c('red3','green3', 'white' )
background.color<-c('dodgerblue', 'lightpink', 'orange')
pie2<-patternpie(group=data$group,pct=data$pct,label=data$label, label.distance=1.3, pattern.type=pattern.type,
           pattern.color=pattern.color,background.color=background.color, 
           pattern.line.size=c(10, 10, 2), frame.color='grey40',frame.size=1.5, pixel=12, density=c(8, 8, 10))
pie2<-pie2+ggtitle('(B) Colors with Patterns')

library(gridExtra)
grid.arrange(pie1,pie2,  nrow = 1)


## ----e2, fig.height = 6, fig.width = 6-----------------------------------
library(patternplot)
library(ggplot2)
library(jpeg)
Tomatoes <-  readJPEG(system.file("img", "tomatoes.jpg", package="patternplot"))
Peas <- readJPEG(system.file("img", "peas.jpg", package="patternplot"))
Potatoes <-  readJPEG(system.file("img", "potatoes.jpg", package="patternplot"))

#Example 1
data <- read.csv(system.file("extdata", "vegetables.csv", package="patternplot"))
pattern.type<-list(Tomatoes,Peas,Potatoes)
imagepie(group=data$group,pct=data$pct,label=data$label,pattern.type=pattern.type,
         label.distance=1.3,frame.color='burlywood4', frame.size=0.8, label.size=6,
         label.color='forestgreen')+ggtitle('Pie Chart with Images')

## ----e3, fig.height = 6.5, fig.width = 6.5-------------------------------
library(patternplot)
library(png)
library(ggplot2)
group1<-c('New_England', 'Great_Lakes','Plains',  'Rocky_Mountain', 'Far_West','Southwest', 'Southeast',  'Mideast')
pct1<-c( 12, 11, 17, 15, 8, 11,  16,  10)
label1<-paste(group1, " \n ", pct1, "%", sep="")

pattern.type1<-c("hdashes", "blank", "grid", "blank", "hlines", "blank", "waves", "blank")
pattern.type.inner<-"blank"
pattern.color1<-rep("white", 8)
background.color1<-c("darkgreen", "darkcyan", "chocolate", "cadetblue1", "darkorchid", "yellowgreen", "hotpink", "lightslateblue")
density1<-rep(11.5, length(group1))
pattern.line.size1=c(10, 1, 6, 1, 10, 1, 6, 1)

g<-patternring1(group1, pct1, label1, label.size1=4,label.color1='black', label.distance1=1.36, pattern.type1, pattern.color1, pattern.line.size1,background.color1, frame.color='black',frame.size=1.2, density1, pixel=13,
                pattern.type.inner="blank",pattern.color.inner="white", pattern.line.size.inner=1,  background.color.inner="white", pixel.inner=10, density.inner=1, r1=2.7, r2=4)
g<-g+annotate(geom="text", x=0, y=0, label="2019 Number of Cases \n N=1000",color="black", size=4)+scale_x_continuous(limits=c(-7, 7))+scale_y_continuous(limits=c(-7, 7))
g


## ----e4, fig.height = 6, fig.width = 6-----------------------------------
#Example 1
library(patternplot)
library(png)
library(ggplot2)
location<-gsub('\\','/',tempdir(), fixed=T)
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="darkgreen", pixel=8, res=8)
FarWest<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="darkcyan", pixel=8, res=8)
GreatLakes<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="chocolate", pixel=8, res=8)
Mideast<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="cadetblue1", pixel=8, res=8)
NewEngland<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="darkorchid", pixel=8, res=8)
Plains<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="yellowgreen", pixel=8, res=8)
RockyMountain<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="hotpink", pixel=8, res=8)
Southeast<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="lightslateblue", pixel=8, res=8)
Southwest <-readPNG(paste(location,'/',"blank",".png", sep=''))


group1<-c('New_England', 'Great_Lakes','Plains',  'Rocky_Mountain', 'Far_West','Southwest', 'Southeast',  'Mideast')
pct1<-c( 12, 11, 17, 15, 8, 11,  16,  10)
label1<-paste(group1, " \n ", pct1, "%", sep="")

pattern.type1<-list(NewEngland, GreatLakes,Plains,  RockyMountain, FarWest,Southwest, Southeast,  Mideast)
pattern.type.inner<-readPNG(system.file("img", "USmap.png", package="patternplot"))

g<-imagering1(group1, pct1,  pattern.type1, pattern.type.inner, frame.color='black',frame.size=1.5, r1=3, r2=4,label1, label.size1=4,label.color1='black', label.distance1=1.3)
g<-g+annotate(geom="text", x=0, y=-2, label="2019 Number of Cases \n N=1000",color="black", size=4)+scale_x_continuous(limits=c(-6, 6))+scale_y_continuous(limits=c(-6, 6))
g


## ----e5, fig.height = 6, fig.width = 10----------------------------------
library(patternplot)
library(png)
library(ggplot2)

group1<-c("Wind", "Hydro", "Solar", "Coal", "Natural Gas", "Oil")
pct1<-c(12, 15, 8, 22, 18, 25)
label1<-paste(group1, " \n ", pct1 , "%", sep="")

group2<-c("Renewable", "Non-Renewable")
pct2<-c(35, 65)
label2<-paste(group2, " \n ", pct2 , "%", sep="")

pattern.type1<-rep(c( "blank"), times=6)
pattern.type2<-c('grid', 'blank')
pattern.type.inner<-"blank"
pattern.color1<-rep('white', length(group1))
pattern.color2<-rep('white', length(group2))

background.color1<-c("darkolivegreen1", "white", "indianred", "gray81",  "white", "sandybrown" )
background.color2<-c("seagreen", "deepskyblue")

density1<-rep(10, length(group1))
density2<-rep(10, length(group2))

pattern.line.size1=rep(5, length(group1))
pattern.line.size2=rep(2, length(group2))
pattern.line.size.inner=1

#Example 1: Two rings
g<-patternrings2(group1, group2, pct1,pct2, label1, label2, label.size1=3, label.size2=3.5, label.color1='black', label.color2='black', label.distance1=0.75, label.distance2=1.4, pattern.type1, pattern.type2,  pattern.color1,pattern.color2,
pattern.line.size1, pattern.line.size2, background.color1, background.color2,density1=rep(10, length(group1)), density2=rep(15, length(group2)),pixel=10, pattern.type.inner, pattern.color.inner="black",pattern.line.size.inner,  background.color.inner="white",  pixel.inner=6,  density.inner=5, frame.color='black',frame.size=1.5,r1=2.45, r2=4.25, r3=5)
g1<-g+annotate(geom="text", x=0, y=0, label="Earth's Energy",color="black", size=5)+scale_x_continuous(limits=c(-6, 6))+scale_y_continuous(limits=c(-6, 6))+ggtitle("(A) Two Rings")

#Example 2: Pie in a ring
g<-patternrings2(group1, group2, pct1,pct2, label1, label2, label.size1=3, label.size2=3.5, label.color1='black', label.color2='black', label.distance1=0.7, label.distance2=1.4, pattern.type1, pattern.type2,  pattern.color1,pattern.color2,
pattern.line.size1, pattern.line.size2, background.color1, background.color2,density1=rep(10, length(group1)), density2=rep(15, length(group2)),pixel=10, pattern.type.inner, pattern.color.inner="black",pattern.line.size.inner,  background.color.inner="white",  pixel.inner=2,  density.inner=5, frame.color='black',frame.size=1.5, r1=0.005, r2=4, r3=4.75)
g2<-g+scale_x_continuous(limits=c(-6, 6))+scale_y_continuous(limits=c(-6, 6))+ggtitle("(B) Pie in a Ring")


library(gridExtra)
grid.arrange(g1,g2,  nrow = 1)


## ----e6, fig.height = 6, fig.width = 6-----------------------------------
#Example 1
library(patternplot)
library(png)
library(ggplot2)
group1<-c("Wind", "Hydro", "Solar", "Coal", "Natural Gas", "Oil")
pct1<-c(12, 15, 8, 22, 18, 25)
label1<-paste(group1, " \n ", pct1 , "%", sep="")
location<-gsub('\\','/',tempdir(), fixed=T)
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="darkolivegreen1",  pixel=20, res=15)
Wind<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="white", pixel=20, res=15)
Hydro<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="indianred",  pixel=20, res=15)
Solar<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="gray81",  pixel=20, res=15)
Coal<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="white",  pixel=20, res=15)
NaturalGas<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="sandybrown",  pixel=20, res=15)
Oil<-readPNG(paste(location,'/',"blank",".png", sep=''))
pattern.type1<-list(Wind, Hydro, Solar, Coal, NaturalGas, Oil)

group2<-c("Renewable", "Non-Renewable")
pct2<-c(35, 65)
label2<-paste(group2, " \n ", pct2 , "%", sep="")
pattern(type="grid", density=12, color='white', pattern.line.size=5, background.color="seagreen", pixel=20, res=15)
Renewable<-readPNG(paste(location,'/',"grid",".png", sep=''))
pattern(type="blank", density=1, color='white', pattern.line.size=1, background.color="deepskyblue",  pixel=20, res=15)
NonRenewable<-readPNG(paste(location,'/',"blank",".png", sep=''))

pattern.type2<-list(Renewable, NonRenewable)
pattern.type.inner<-readPNG(system.file("img", "earth.png", package="patternplot"))

g<-imagerings2(group1, group2,pct1,pct2, label1, label2, label.size1=3, label.size2=3.5, label.color1='black', label.color2='black', label.distance1=0.7, label.distance2=1.3, pattern.type1, pattern.type2, pattern.type.inner, frame.color='skyblue',frame.size=1.5, r1=2.2, r2=4.2, r3=5)
g<-g+scale_x_continuous(limits=c(-7, 7))+scale_y_continuous(limits=c(-7, 7))
g


## ----e7, fig.width=6, fig.height=6---------------------------------------
#Example 1
library(patternplot)
library(png)
library(ggplot2)
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
data<-data[which(data$Location=='City 1'),]
x<-factor(data$Type, c('Housing', 'Food',  'Childcare'))
y<-data$Amount
pattern.type<-c('hdashes', 'blank', 'crosshatch')
pattern.color=c('black','black', 'black')
background.color=c('white','white', 'white')
density<-c(20, 20, 10)
barp1<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type, hjust=0.5,
           pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),
           frame.color=c('black', 'black', 'black'), density=density)+scale_y_continuous(limits = c(0, 2800))+ggtitle('(A) Black and White with Patterns')

#Example 2
pattern.color=c('black','white', 'grey20')
background.color=c('lightgreen','lightgreen', 'lightgreen')
barp2<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type,hjust=0.5,
           pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),
           frame.color=c('black', 'black', 'black'), density=density)+scale_y_continuous(limits = c(0, 2800))+ggtitle('(B) Colors with Patterns')

library(gridExtra)
grid.arrange(barp1,barp2,  nrow = 1)

#Example 3
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
group<-factor(data$Type, c('Housing', 'Food',  'Childcare'))
y<-data$Amount
x<-factor(data$Location, c('City 1', ' City 1'))
pattern.type<-c( 'Rsymbol_16', 'blank','hdashes')
pattern.color=c('yellow', 'chartreuse4',  'pink')
background.color=c('grey', 'chartreuse3',  'bisque')
barp3<-patternbar(data,x, y,group,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type, 
                  pattern.color=pattern.color,background.color=background.color, pattern.line.size=c(6, 10,6),
                  frame.size=1,frame.color='black',pixel=16, density=c(18, 10, 14), legend.type='h', 
                  legend.h=12, legend.y.pos=0.49, vjust=-1, hjust=0.5,legend.pixel=6, legend.w=0.275,legend.x.pos=1.1) +scale_y_continuous(limits = c(0, 3100))+ggtitle('(C) Bar Chart with Two Grouping Variables')
barp3

## ----e8, fig.width=6, fig.height=6---------------------------------------
#Example 1
library(patternplot)
library(png)
library(ggplot2)
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
x<-data$Location
y<-data$Amount
group<-data$Type

patternbar_s(data,x, y, group,xlab='', ylab='Monthly Expenses, Dollar', label.size=3,pattern.type=c( 'Rsymbol_16', 'blank','hdashes'), pattern.line.size=c(5, 10, 10),frame.size=1,pattern.color=c('yellow', 'chartreuse4',  'pink'),background.color=c('grey', 'chartreuse3',  'bisque'), pixel=16, density=c(18, 10, 10),frame.color='black', legend.type='h', legend.h=12, legend.y.pos=0.49, legend.pixel=6, legend.w=0.275, legend.x.pos=1.05, bar.width=0.8)+scale_y_continuous(limits = c(0, 6800))+ggtitle('Stacked Bar Chart')

## ----e9, fig.width=6, fig.height=6---------------------------------------
library(patternplot)
library(jpeg)
library(ggplot2)

childcare<-readJPEG(system.file("img", "childcare.jpg", package="patternplot"))
food<-readJPEG(system.file("img", "food.jpg", package="patternplot"))
housing <-readJPEG(system.file("img", "housing.jpg", package="patternplot"))

#Example 1
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
data<-data[which(data$Location=='City 1'),]
x<-factor(data$Type, c('Housing', 'Food',  'Childcare'))
y<-data$Amount
pattern.type<-list(housing, food, childcare)
imagebar(data,x, y,group=NULL,pattern.type=pattern.type,vjust=-1, hjust=0.5,
         frame.color='black',
         ylab='Monthly Expenses, Dollars')+ggtitle('(A) Bar Chart with Images')

#Example 2
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
group<-factor(data$Type, c('Housing', 'Food',  'Childcare'))
y<-data$Amount
x<-factor(data$Location, c('City 1', ' City 1'))
pattern.type<-list(housing, food, childcare)
imagebar(data,x, y,group,pattern.type=pattern.type,vjust=-1, hjust=0.5,
         frame.color='black',
         ylab='Monthly Expenses, Dollars')+ggtitle('(B) Image Bar Chart with Two Grouping Variables')

## ----e10, fig.width=6, fig.height=6--------------------------------------
library(patternplot)
library(jpeg)
library(ggplot2)

childcare<-readJPEG(system.file("img", "childcare.jpg", package="patternplot"))
food<-readJPEG(system.file("img", "food.jpg", package="patternplot"))
housing <-readJPEG(system.file("img", "housing.jpg", package="patternplot"))

data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
x<-data$Location
y<-data$Amount
group<-data$Type
pattern.type<-list(childcare, food, housing)

imagebar_s(data,x, y, group, xlab='', ylab='Monthly Expenses, Dollar',  pattern.type=pattern.type, label.size=3.5, frame.size=1.25, frame.color='black',legend.type='h', legend.h=6, legend.y.pos=0.49, legend.pixel=20, legend.w=0.2,legend.x.pos=1.1)+ scale_y_continuous(limits = c(0, 6800))+ggtitle('Stacked Bar Chart with Images')


## ----e11, fig.height = 6, fig.width = 12---------------------------------
#Example 1
data <- read.csv(system.file("extdata", "fruits.csv", package="patternplot"))
group<-data$Fruit
y<-data$Weight
x<-data$Store

pattern.type<-c('nwlines', 'blank', 'waves')
pattern.color=c('black','black', 'black')
background.color=c('white','gray80', 'white')
frame.color=c('black', 'black', 'black')
pattern.line.size<-c(6, 1,6)
density<-c(6, 1, 8)
box1<-patternboxplot(data,x, y,group,pattern.type=pattern.type,pattern.line.size=pattern.line.size, label.size=3,
               pattern.color=pattern.color, background.color=background.color,frame.color=frame.color, 
               density=density,  legend.h=2, legend.x.pos=1.075, legend.y.pos=0.499, legend.pixel=10, legend.w=0.18)+ggtitle('(A) Boxplot with Black and White Patterns')

#Example 2
pattern.color=c('black','white', 'grey20')
background.color=c('gold','lightpink', 'lightgreen')
box2<-patternboxplot(data,x, y,group=group,pattern.type=pattern.type,pattern.line.size=pattern.line.size, label.size=3,
               pattern.color=pattern.color, background.color=background.color,
               frame.color=frame.color, density=density,  legend.h=2, legend.x.pos=1.075, legend.y.pos=0.499, legend.pixel=10, legend.w=0.18)+ggtitle('(B) Boxplot with Colors and Patterns')

library(gridExtra)
grid.arrange(box1,box2,  nrow = 1)

## ----e12, fig.height = 6, fig.width = 12---------------------------------
library(patternplot)
library(jpeg)
library(ggplot2)

Orange<-readJPEG(system.file("img", "oranges.jpg", package="patternplot"))
Strawberry <-readJPEG(system.file("img", "strawberries.jpg", package="patternplot"))
Watermelon<-readJPEG(system.file("img", "watermelons.jpg", package="patternplot"))

#Example 1
data <- read.csv(system.file("extdata", "fruits.csv", package="patternplot"))
x<-data$Fruit
y<-data$Weight
group<-data$Store
pattern.type<-list(Orange, Strawberry, Watermelon)
box1<-imageboxplot(data,x, y,group=NULL,pattern.type=pattern.type,frame.color=c('orange', 'darkred', 'darkgreen'),ylab='Weight, Pounds')+ggtitle('(A) Image Boxplot with One Grouping Variable')

#Example 2
x<-data$Store
y<-data$Weight
group<-data$Fruit
pattern.type<-list(Orange, Strawberry, Watermelon)
box2<-imageboxplot(data,x, y,group=group, pattern.type=pattern.type, frame.color=c('orange', 'darkred', 'darkgreen'), linetype=c('solid', 'dashed', 'dotted'),frame.size=0.8, xlab='', ylab='Weights, pounds', legend.h=2, legend.x.pos=1.1, legend.y.pos=0.499, legend.w=0.2)+ggtitle('(B) Image Boxplot with Two Grouping Variables')

library(gridExtra)
grid.arrange(box1,box2,  nrow = 1)

## ----e13, fig.height = 6, fig.width = 12---------------------------------
library(patternplot)
library(png)
library(ggplot2)
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
data<-data[which(data$Location=='City 1'),]
x<-factor(data$Type, c('Housing', 'Food',  'Childcare'))
y<-data$Amount
pattern.type<-c('hdashes', 'blank', 'crosshatch')
pattern.color=c('black','black', 'black')
background.color=c('white','white', 'white')
density<-c(20, 20, 10)

g1<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),frame.color=c('black', 'black', 'black'), density=density, vjust=-1, hjust=0.5, bar.width=0.75)+scale_y_continuous(limits = c(0, 2800))+ggtitle('(A) Vertical Bar Chart')

g2<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),frame.color=c('black', 'black', 'black'), density=density, vjust=0.5, hjust=-0.25, bar.width=0.5)+scale_y_continuous(limits = c(0,2800))+ggtitle('(B) Horizontal Bar Chart')+coord_flip()

g3<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),frame.color=c('black', 'black', 'black'), density=density, vjust=2, hjust=0.5, bar.width=0.75)+ggtitle('(C) Reverse Bar Chart')+ scale_y_reverse(limits = c(2800,0))

library(gridExtra)
grid.arrange(g1,g2,g3,  nrow = 1)

## ----e14, fig.height = 6, fig.width = 10---------------------------------
library(patternplot)
library(png)
library(ggplot2)
data <- read.csv(system.file("extdata", "monthlyexp.csv", package="patternplot"))
data<-data[which(data$Location=='City 1'),]
x<-factor(data$Type, c('Housing', 'Food',  'Childcare'))
y<-data$Amount
pattern.type<-c('hdashes', 'blank', 'crosshatch')
pattern.color=c('black','black', 'black')
background.color=c('white','white', 'white')
density<-c(20, 20, 10)

g1<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),frame.color=c('black', 'black', 'black'), density=density, vjust=-1, hjust=0.5)+scale_y_continuous(limits = c(0, 2800))+ggtitle('(A) Bar Chart with Default Theme')

g2<-patternbar(data,x, y,group=NULL,ylab='Monthly Expenses, Dollars', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(5.5, 1, 4),frame.color=c('black', 'black', 'black'), density=density, vjust=-1, hjust=0.5)+scale_y_continuous(limits = c(0, 2800))+ggtitle('(B) Bar Chart with Classic Theme')+ theme_classic()

library(gridExtra)
grid.arrange(g1,g2,  nrow = 1)

## ----e15, fig.height = 6, fig.width = 10---------------------------------
library(patternplot)
library(png)
library(ggplot2)
#http://www.alanwood.net/demos/wgl4.html
data <- data.frame(Type=c('Sunny', 'Cloudy', 'Rainy', 'Snowy'), Amount=c(5, 2, 3, 4))
x<-factor(data$Type, c('Sunny', 'Cloudy', 'Rainy', 'Snowy'))
y<-data$Amount
pattern.type<-c('Unicode_\u2600', 'Unicode_\u2601', 'Unicode_\u2602', 'Unicode_\u2603')
pattern.color<-c('yellow','white','red', 'white')
background.color=c('deepskyblue','deepskyblue','deepskyblue',  'deepskyblue')
density<-c(16, 20, 16, 16)
g1<-patternbar(data,x, y,group=NULL,ylab='Number of Days', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(10, 7, 10, 10), density=density, vjust=-1, hjust=0.5, bar.width =0.5)+scale_y_continuous(limits = c(0, 6))+ggtitle('(A) Bar Chart with Weather Symbols')

data <- data.frame(Type=c('Female', 'Male'), Amount=c(50, 40))
x<-data$Type
y<-data$Amount
pattern.type<-c('Unicode_\u2640', 'Unicode_\u2642')
pattern.color<-c('violet','deepskyblue')
background.color=c('seashell','seashell')
density<-c(10, 10)
g2<-patternbar(data,x, y,group=NULL,ylab='Number of People', pattern.type=pattern.type,pattern.color=pattern.color, background.color=background.color,pattern.line.size=c(14, 14), density=density, pixel=18, vjust=-1, hjust=0.5, bar.width =0.5)+scale_y_continuous(limits = c(0, 60))+ggtitle('(B) Bar Chart with Gender Symbols')


library(gridExtra)
grid.arrange(g1,g2,  nrow = 1)

