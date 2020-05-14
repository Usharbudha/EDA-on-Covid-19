install.packages("remotes")
remotes::install_github("GuangchuangYu/nCov2019")
library(nCov2019)
x=get_nCov2019(lang = 'en')#for latest data
x
x['global',]#for global data
x[]
x[1,]#for more granular data like name of patients in hubei
library(forcats)
library(ggplot2)
d=x['Anhui',]
d$confirm=as.numeric(d$confirm)
d$name=fct_reorder(d$name,d$confirm)
ggplot(d,aes(name,confirm))+geom_col(fill='steelblue')+coord_flip()+geom_text(aes(y=confirm+2,label=confirm),hjust=0)+theme_minimal(base_size = 14)+scale_y_continuous(expand = c(0,10))+xlab(NULL)+ylab(NULL)
#for daily data
head(x[by='today'],10)
x['Hubei',by='today']
summary(x)
summary(x,by="today")
ggplot(summary(x),aes(as.Date(date,"%m.%d"),as.numeric(confirm)))+geom_col(fill='firebrick')+theme_minimal(base_size = 14)+xlab(NULL)+ylab(NULL)+labs(caption=paste("accessed date:",time(x)))

#for historical data
x=load_nCov2019(lang = 'en')
head(x[][c(1:6,9:11)])
head(x['Hubei',c(1:6,9:11)])
head(subset(x['Hubei',],city=="Wuhan"))[c(1:6,9:11)]
require(ggrepel)
d=x['Anhui',]
ggplot(d,aes(time,as.numeric(cum_confirm),group=city,color=city))+geom_point()+geom_line()+geom_text_repel(aes(label=city),data=d[d$time==time(x),],hjust=1)+theme_minimal(base_size = 14)+theme(legend.position = 'none')+xlab(NULL)+ylab(NULL)
head(summary(x)[,1:5])
summary(x,'Hubei')[,1:5]
ggplot(summary(x,'Hubei'),aes(time,as.numeric(cum_confirm)))+geom_col()
ggplot(subset(x['Hubei',],city=="Huanggang"),aes(time,as.numeric(cum_confirm)))+geom_col()

x=get_nCov2019(lang = 'en')
plot(x)

remotes::install_github("GuangchuangYu/chinamap")
require(chinamap)
cn=get_map_china()
cn$province=trans_province(cn$province)
plot(x,chinamap = cn)
plot(x,chinamap = cn,palette = "Purples")
plot(x,region='china',chinamap=cn,font.size=2)
