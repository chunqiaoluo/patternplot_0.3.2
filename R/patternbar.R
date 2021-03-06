#' Plot a bar chart using patterns and colors to fill the bars.
#'
#' The \code{patternbar} function is a tool for creating versatile bar charts 
#' by filling the bars with colors and patterns.  
#' @importFrom Rcpp evalCpp
#' @useDynLib patternplot 
#' @param data the data to be used. 
#' @param x the variable used on x axis.
#' @param y the variable used on y axis.
#' @param group the variable used as the second grouping variable on x axis.
#' @param xlab a character string to give x axis label.
#' @param ylab a character string to give y axis label.
#' @param label.size the font size of legend labels shown above the bars.   
#' @param vjust the vertical distance of labels from the top border of each bar. 
#' @param hjust the horizontal distance of labels from the top border of each bar. 
#' @param pattern.type a vector of patterns to be filled in the bars 
#' The pattern types include: 'blank', 'bricks', 'vdashes', 'hdashes', 'crosshatch','dots', 
#' 'grid','hlines','nelines', 'nwlines', 'vlines', 'waves' and more. 
#' @param pattern.line.size a vector of numeric values, the line size for the lines/dots of patterns.
#' @param pattern.color a vector of colors for the lines/dots of patterns.
#' @param background.color a vector of colors to be filled in the bars.
#' @param frame.color the color for the borders of bars.
#' @param frame.size a numeric value, the line size for the borders of bars.
#' @param pixel a numeric value, the pixel resolution of bar chart. 
#' @param density a numeric vector, the density for the lines/dots of patterns. 
#' @param legend.type if legend.type='h', the layout of legends is horizontal; if legend.type='v', the layout of legends is vertical. 
#' @param legend.h a numeric value to change the height of legend boxes.
#' @param legend.x.pos a numeric value to change the position of legends on x axis.
#' @param legend.y.pos a numeric value to change the position of legends on y axis.
#' @param legend.w a numeric value to change the width of legends. 
#' @param legend.pixel a numeric value to change pixel of legends.
#' @param bar.width a numeric value to change the width of the bars. 
#' @return  A ggplot object.
#'
#' @details \code{patternbar} function offers flexible ways of doing bar charts.
#'   
#' @author Chunqiao Luo (chunqiaoluo@gmail.com)
#'
#' @seealso Function \code{imagebar}  
#'
#' @example vignettes/example-patternbar.R

patternbar<-function(data,x, y, group=NULL, xlab='', ylab='',  label.size=3.5,vjust=-1,hjust=-1,
          pattern.type, pattern.line.size=rep(5, ifelse(is.null(group), length(x), length(unique(group)))),
          pattern.color=rep('black', ifelse(is.null(group), length(x), length(unique(group)))),
          background.color=rep('white', ifelse(is.null(group), length(x), length(unique(group)))), 
          frame.color=rep('black', ifelse(is.null(group), length(x), length(unique(group)))),frame.size=1, 
				  pixel=20, density=rep(7, ifelse(is.null(group), length(x), length(unique(group)))),
				  legend.type='h', legend.h=6, legend.x.pos=1.1, legend.y.pos=0.49, legend.w=0.2, legend.pixel=20, bar.width=0.9){
  location<-gsub('\\','/',tempdir(), fixed=T)
  if(is.null(group)){
    
    bplot <- ggplot(data, aes(x, y)) + geom_bar(stat="identity", width = bar.width)+geom_text(aes(label=y)) 
    
    #Box Data
    gdata<-ggplot_build(bplot)$data[[1]]
    gdata<-gdata[order(gdata$group),]
    boxmatrix<-list()
    picdata<-list()
    picdf<-list()
    xmax<-max(gdata[, c('xmax')])
    xmin<-min(gdata[, c('xmin')])
    ymax<-max(gdata[, c('ymax')])
    ymin<-min(gdata[, c('ymin')])
    for (i in 1:dim(gdata)[1]){
      boxmatrix[[i]]<-matrix(c(gdata[i,"xmin"], 0,
                               gdata[i,"xmax"], 0,
                               gdata[i,"xmax"], gdata[i,"ymax"],
                               gdata[i,"xmin"], gdata[i,"ymax"],
                               gdata[i,"xmin"], 0),
                             nrow=5, 
                             ncol=2, byrow=T)
      suppressWarnings(pattern(type=pattern.type[i], density=density[i], color=pattern.color[i], pattern.line.size=pattern.line.size[i], background.color=background.color[i], pixel=pixel, res=pixel))
      if (sub( "_.*", "", pattern.type[i])=='Unicode'){
        picdata[[i]]<-imagetodf2(readPNG(paste(location,'/','Unicode',".png", sep='')),  boxmatrix[[i]],left =xmin, right = xmax ,bottom = ymin,top =ymax)
      }else{
        picdata[[i]]<-imagetodf2(readPNG(paste(location,'/',pattern.type[i],".png", sep='')),  boxmatrix[[i]],left =xmin, right = xmax ,bottom = ymin,top =ymax)
      } 
      
      picdata[[i]] <- filter(picdata[[i]], pos==1)
    }


    
    #Text Data
    ldata<-ggplot_build(bplot)$data[[2]]
    
    g<- ggplot()+ mapply(function(i) geom_tile(data = picdata[[i]], aes(x = X, y = Y, fill = rgb(r,g, b,a))),1:dim(gdata)[1])+scale_fill_identity()+geom_rect(aes(xmin=gdata[,"xmin"],xmax=gdata[,"xmax"],ymin=0,ymax=gdata[,"ymax"]), color=frame.color,size=frame.size, fill=NA)
    g+ theme_bw()+xlab(xlab)+ylab(ylab)+ scale_x_continuous(breaks=seq(1:length(levels(x))), labels=levels(x))+geom_text(data=ldata, aes(x, y, label=label), vjust=vjust,hjust=hjust, size=label.size)
    
  }else{
    
    bplot <- ggplot(data, aes(x, y, fill=group)) + geom_bar(stat="identity", position=position_dodge(), width = bar.width) +geom_text(aes(label=y),position=position_dodge(width=0.9)) 
    gdata<-ggplot_build(bplot)$data[[1]]
    gdata<-gdata[order(gdata$group),]
    boxmatrix<-list()
    picdata<-list()
    picdf<-list()
    xmax<-max(gdata[, c('xmax')])
    xmin<-min(gdata[, c('xmin')])
    ymax<-max(gdata[, c('ymax')])
    ymin<-min(gdata[, c('ymin')])
    pattern.type2<-rep(pattern.type, time=length(unique(x)))
    background.color2<-rep(background.color,time=length(unique(x)))
    pattern.color2<-rep(pattern.color,time=length(unique(x)))
    density2<-rep(density,time=length(unique(x)))
    pattern.line.size2<-rep(pattern.line.size,time=length(unique(x)))
    for (i in 1:dim(gdata)[1]){
      boxmatrix[[i]]<-matrix(c(gdata[i,"xmin"], 0,
                               gdata[i,"xmax"], 0,
                               gdata[i,"xmax"], gdata[i,"ymax"],
                               gdata[i,"xmin"], gdata[i,"ymax"],
                               gdata[i,"xmin"], 0),
                             nrow=5, 
                             ncol=2, byrow=T)
      suppressWarnings(pattern(type=pattern.type2[i], density=density2[i], color=pattern.color2[i], pattern.line.size=pattern.line.size2[i], background.color=background.color2[i], pixel=pixel, res=pixel))
      if (sub( "_.*", "", pattern.type2[i])=='Unicode'){
        picdata[[i]]<-imagetodf2(readPNG(paste(location,'/','Unicode',".png", sep='')),  boxmatrix[[i]],left =xmin, right = xmax ,bottom = ymin,top =ymax)
      }else{
        picdata[[i]]<-imagetodf2(readPNG(paste(location,'/',pattern.type2[i],".png", sep='')),  boxmatrix[[i]],left =xmin, right = xmax ,bottom = ymin,top =ymax)
      } 
      
      picdata[[i]] <- filter(picdata[[i]], pos==1)
    }
    
    
    legendbox<-list()
    legenddata<-list()
    
    if(legend.type=='v'){
      legend.y<-seq(from =ymax+(0.1+0.05*legend.h)*ymax, to = ymax+0.1*ymax, length.out=length(pattern.type)+1)
      legend.x<-seq(from = xmin, to = xmin+ 0.5*(gdata[1,"xmax"]-xmin), length.out=2)
      legend.frame.xmin<-vector(mode="numeric", length=length(pattern.type))
      legend.frame.xmax<-vector(mode="numeric", length=length(pattern.type))
      legend.frame.ymin<-vector(mode="numeric", length=length(pattern.type))
      legend.frame.ymax<-vector(mode="numeric", length=length(pattern.type))
      for (i in 1:length(pattern.type)){
        legendbox[[i]]<-matrix(c(legend.x[1], legend.y[i],
                                 legend.x[2], legend.y[i],
                                 legend.x[2],legend.y[i+1],
                                 legend.x[1],legend.y[i+1],
                                 legend.x[1],legend.y[i]),
                               nrow=5, 
                               ncol=2, byrow=T)
        
        suppressWarnings(pattern(type=pattern.type[i], density=0.6*density[i], color=pattern.color[i], pattern.line.size=pattern.line.size[i], background.color=background.color[i], pixel=legend.pixel, res=legend.pixel))
        if (sub( "_.*", "", pattern.type[i])=='Unicode'){
          legenddata[[i]]<-imagetodf2(readPNG(paste(location,'/','Unicode',".png", sep='')),  legendbox[[i]],left =legendbox[[i]][1, 1], right = legendbox[[i]][2, 1] ,bottom = legendbox[[i]][1, 2],top =legendbox[[i]][3, 2])
        
        }else{
          legenddata[[i]]<-imagetodf2(readPNG(paste(location,'/',pattern.type[i],".png", sep='')),  legendbox[[i]],left =legendbox[[i]][1, 1], right = legendbox[[i]][2, 1] ,bottom = legendbox[[i]][1, 2],top =legendbox[[i]][3, 2])
        }
        legend.frame.xmin[i]<-legend.x[1]
        legend.frame.xmax[i]<-legend.x[2]
        legend.frame.ymax[i]<-legend.y[i]
        legend.frame.ymin[i]<-legend.y[i+1]
      }
      legend.label.y<-legend.y.pos*(legend.frame.ymin+legend.frame.ymax)
      legend.label.x<-legend.x.pos*legend.w
      
    }
    
    if(legend.type=='h'){
      legend.y<-c(ymax+0.1*ymax, ymax+(0.1+0.01*legend.h)*ymax)
      legend.x.s<-seq(from =xmin, to =0.67* xmax, length.out=length(pattern.type))
      legend.frame.xmin<-vector(mode="numeric", length=length(pattern.type))
      legend.frame.xmax<-vector(mode="numeric", length=length(pattern.type))
      legend.frame.ymin<-vector(mode="numeric", length=length(pattern.type))
      legend.frame.ymax<-vector(mode="numeric", length=length(pattern.type))
      for (i in 1:length(pattern.type)){
        legendbox[[i]]<-matrix(c(legend.x.s[i], legend.y[1],
                                 legend.x.s[i]+legend.w, legend.y[1],
                                 legend.x.s[i]+legend.w,legend.y[2],
                                 legend.x.s[i],legend.y[2],
                                 legend.x.s[i],legend.y[1]),
                               nrow=5, 
                               ncol=2, byrow=T)
        suppressWarnings(pattern(type=pattern.type[i], density=0.6*density[i], color=pattern.color[i], pattern.line.size=pattern.line.size[i], background.color=background.color[i], pixel=legend.pixel, res=legend.pixel))
        if (sub( "_.*", "", pattern.type[i])=='Unicode'){
          legenddata[[i]]<-imagetodf2(readPNG(paste(location,'/','Unicode',".png", sep='')),  legendbox[[i]],left =legendbox[[i]][1, 1], right = legendbox[[i]][2, 1] ,bottom = legendbox[[i]][1, 2],top =legendbox[[i]][3, 2])
          
        }else{
          legenddata[[i]]<-imagetodf2(readPNG(paste(location,'/',pattern.type[i],".png", sep='')),  legendbox[[i]],left =legendbox[[i]][1, 1], right = legendbox[[i]][2, 1] ,bottom = legendbox[[i]][1, 2],top =legendbox[[i]][3, 2])
        }
        legend.frame.xmin[i]<-legendbox[[i]][1,1]
        legend.frame.xmax[i]<-legendbox[[i]][2,1]
        legend.frame.ymax[i]<-legendbox[[i]][3,2]
        legend.frame.ymin[i]<-legendbox[[i]][1,2]
      }
      legend.label.y<-(legend.frame.ymin+legend.frame.ymax)*legend.y.pos
      legend.label.x<-legend.x.s+legend.x.pos*legend.w
    }
    
    #Text Data
    ldata<-ggplot_build(bplot)$data[[2]]
    
    X<-Y<-r<-g<-b<-a<-pos<-label<-NULL
    g<- ggplot()+ mapply(function(i) geom_tile(data = picdata[[i]], aes(x = X, y = Y, fill = rgb(r,g, b,a))),1:dim(gdata)[1])+scale_fill_identity()+geom_rect(aes(xmin=gdata[,"xmin"],xmax=gdata[,"xmax"],ymin=0,ymax=gdata[,"ymax"]), color=frame.color,size=frame.size, fill=NA)
    g<-g+ theme_bw()+xlab(xlab)+ylab(ylab)+ scale_x_continuous(breaks=seq(1:length(levels(x))), labels=levels(x))+geom_text(data=ldata, aes(x, y, label=label), vjust=vjust,hjust=hjust, size=label.size)
    g+ mapply(function(i) geom_tile(data = legenddata[[i]], aes(x = X, y = Y, fill = rgb(r,g, b,a))),1:length(pattern.type))+geom_rect(aes(xmin=legend.frame.xmin,xmax=legend.frame.xmax,ymin=legend.frame.ymin,ymax=legend.frame.ymax), color=frame.color,size=frame.size, fill=NA)+geom_text(aes(x=legend.label.x, y=legend.label.y, label=levels(group), hjust=0, vjust=0), size=label.size)
 
     }
    
  }


