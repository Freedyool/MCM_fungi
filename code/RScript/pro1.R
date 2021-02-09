library(tidyverse)
library(concaveman)
setwd("D:\\R_workbench")

Experimental_outcomes <- read.csv("D:/R_workbench/comp/data/Experimental_outcomes.csv")
exper = na.omit(Experimental_outcomes)
dat <- exper %>%
  select(plate.no, s1, s2, s1.win, s1.loss, draw) %>%
  mutate(value = s1.win*1+s1.loss*0+draw*0.5)　%>%
  select(s1,s2,value)
name <- unique(c(unique(exper[['s1']]),unique(exper[['s2']])))
n = length(name)
mat <- matrix(NA,n,n,dimnames = list(name,name))


for(i in c(1:nrow(dat))){
  s1 = dat$s1[i]
  s2 = dat$s2[i]
  ind1 = which(name==s1)
  ind2 = which(name==s2)
  if(!is.na(mat[ind1,ind2]) || !is.na(mat[ind1,ind2])){
    cat('something wrong')
  }
  mat[ind1,ind2] = dat$value[i]
  mat[ind2,ind1] = 1-dat$value[i]
}
write.csv(mat,'./comp/data/mat.csv')



for(i in c(1:(n-1))){
  for(j in c((i+1):n)){
    row1 <- filter(dat, s1==name[i],s2==name[j])
    row2 <- filter(dat, s1==name[j],s2==name[i])
    if(nrow(row1)+nrow(row2) == 1){
      if(nrow(row1) == 1){
        row <- row1
      }else{
        row <- row2
      }
      mat[i,j] <- row[['value']]
      mat[j,i] <- 1-row[['value']]
    }else{
      cat(nrow(row1),nrow(row2),'\n')
      mat[i,j] <- NA
      mat[j,i] <- NA
    }
  }
}

write.csv(mat,'./comp/data/mat.csv')



library(readxl)
# 分解率 Decomposition rate (% dry mass loss)
SI1 <- read_excel("comp/data/SI.xlsx", sheet = "S3",skip = 1)
# 延伸量 Extension rate (mm day-1) 
SI2 <- read_excel("comp/data/SI.xlsx", sheet = "S4",skip = 1)

# 可视化窗口
esquisse::esquisser()

data = data.frame(
  name = rep(SI1[[1]],3),
  de_rate = c(SI1[[2]],SI1[[3]],SI1[[4]]),
  ex_rate = c(SI2[[2]],SI2[[3]],SI2[[4]]),
  tempreture = c(rep('10',34),rep('16',34),rep('22',34))
)

data$de_rate = data$de_rate/max(data$de_rate)
data$ex_rate = data$ex_rate/max(data$ex_rate)

data %>%
  ggplot()+
  geom_point(aes(x = tempreture,y=de_rate,color='分解率'))+
  geom_point(aes(x = tempreture,y=ex_rate,color='延展率'))+
  facet_wrap(vars(name)) +
  theme_minimal()+
  labs(color = '类别')

ggplot(data) +
  aes(x = tempreture, fill = tempreture, weight = de_rate) +
  geom_bar(position = "dodge") +
  scale_fill_hue() +
  theme_minimal() +
  facet_wrap(vars(name)) +
  labs(x='',y='', fill = 'tempreture/℃')+
  theme(legend.position = 'top')

data %>%
  filter(ex_rate>0) %>%
  ggplot() +
  aes(x = ex_rate, y = de_rate, colour = tempreture) +
  geom_point(size = 5L) +
  geom_smooth(formula = y ~ log(x)) +
  # scale_color_brewer(palette = "Oranges") +
  theme_minimal()

##### 数据处理
moisture_curves <- read.csv("D:/R_workbench/comp/data/Fungi_moisture_curves.csv")
temperature_curves <- read.csv("D:/R_workbench/comp/data/Fungi_temperature_curves.csv")

moisture_curves %>%
  filter(type=='measured')%>%
  # filter(type=='smoothed')%>%
  group_by(species)%>%
  select(species,matric_pot,hyphal_rate) %>%
  group_walk(~ write.csv(.x, file = file.path("D:\\R_workbench\\comp\\data", paste0(.y$species, '_moisture',".csv"))))

temperature_curves %>%
  # filter(type=='measured')%>%
  filter(type=='smoothed')%>%
  group_by(species)%>%
  select(species,temp_c,hyphal_rate) %>%
  group_walk(~ write.csv(.x, file = file.path("D:\\R_workbench\\comp\\data", paste0(.y$species, '_tempreture',".csv"))))

