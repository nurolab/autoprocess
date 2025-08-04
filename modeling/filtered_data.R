library(stats)
getwd()
setwd('/home/deep/Documents/Morphometrical_analysis_for_CD')
data <- read.csv(file = 'qdec_no_outlier.csv', sep = ',', header = T)
data1 <- data.frame(data$fsid,data$geft)
colnames(data1) <- c('fsid','geft')
write.csv(file = 'qdec_no_outlier_filtered_geft.csv', x = data1)

setwd('/home/deep/Documents/Morphometrical_analysis_for_CD/qdec/stats_tables/')
li <- dir()
for (j in li)
{
  data2 <- read.csv(file = j, header = T, sep = '\t')
  for (i in 2:ncol(data2))
  {
    if(mean(data2[,i]) != 0)
    {
      if(is.numeric(data2[, i]))
      { 
          corr <- cor.test(data1$geft, data2[, i])
          if(corr$p.value < 0.05)
          {
            print(j)
            print(paste0("Correlation between ", colnames(data2[i]), " and GEFT with p < 0.05"))
            print(paste0("Corr coefficient = ", corr$estimate, " ; p-value = ", corr$p.value))      
          }
      }
    }
  }
}
