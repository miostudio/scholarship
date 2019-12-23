setwd("G:\\xampp\\htdocs\\scholarship\\data\\backup\\")
getwd()

ele=read.table("../electRead20190906.txt",header = T,sep="\t")
dim(ele) #[1] 103   2
head(ele)
#        date elecRead
#1 2019-05-31     7.63
#2 2019-06-01     7.63
#3 2019-06-02     7.80

library(ggplot2)
library("Cairo")

eplot=function(n1,n2, title,pdf=FALSE){
  read=ele$elecRead
  g=ggplot(ele[n1:n2,], aes(date, elecRead))+geom_point()+
    theme(axis.text.x=element_text(angle=60, hjust=1,size=8,color="grey50"), #坐标轴刻度旋转60度。
          axis.text.y=element_text(angle=90, hjust=1,size=8))+#guides(fill=FALSE)+
    labs(title=paste0(title, "(", n2-n1+1," days, ",read[n2]-read[n1], 'KWh)' ) )
  if(pdf==FALSE){
    print(g)
  }else{
    CairoPDF(file=paste0(title, ".pdf"), width=5, height=5)
    print(g)
    dev.off();
    print("save to pdf files.")
  }
}

eplot(1,103,"2019.6-9",T)

eplot(2,31,"2019.6",T) #0.2
eplot(32,60,"2019.7",T) #2.27 缺少7.3数据
eplot(61,91,"2019.8",T) #286.56

eplot(92,103,"2019.9",T) #12天 用了46.32KWh
