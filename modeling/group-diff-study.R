library(stats)
rm(list = ls())
getwd()
setwd('/home/deep/Documents/Morphometrical_analysis_for_CD')
data <- read.csv(file = 'qdec_no_outlier.csv', sep = ',', header = T)
data1 <- data.frame(data$fsid,data$geft)
colnames(data1) <- c('fsid','geft')
write.csv(file = 'qdec_no_outlier_filtered_geft.csv', x = data1)

setwd('/home/deep/Documents/Morphometrical_analysis_for_CD/qdec/stats_tables/')
li <- dir()
out <- matrix(nrow = 30, ncol = 6, data = NA)
k <- 1
for (j in li)
{
  data2 <- read.csv(file = j, header = T, sep = '\t')
  data2$geft <- data1$geft
  LEFT <- subset(data2, data2$geft <= 10)
  HEFT <- subset(data2, data2$geft > 10)

  for (i in 2:ncol(data2))
  {
    if(mean(LEFT[,i]) != 0 & mean(HEFT[,i]) != 0)
    {
      if(is.numeric(LEFT[,i]) & is.numeric(HEFT[,i]))
      { 
        difs <- t.test(LEFT[,i], HEFT[,i])
        corr <- cor.test(data2$geft, data2[,i])
        if(difs$p.value < 0.05 & corr$p.value < 0.05 & corr$estimate != 1)
        {
          cat(paste0("\n\nGroup analysis of ",j))
          cat(paste0("\nDifferences between ", "LEFT's ",colnames(LEFT[i]), " and ", "HEFT's ", colnames(HEFT[i]) ," with p < 0.05"))
          cat(paste0("\nT-stat = ", difs$statistic, " ; p-value = ", difs$p.value))
          cat(paste0("\nCorrelation study of ",j,"\n"))
          cat(paste0("Correlation between ", colnames(data2[i]), " and GEFT with p < 0.05"))
          cat(paste0("\nCorr coefficient = ", corr$estimate, " ; p-value = ", corr$p.value))
          out[k,1] <- j
          out[k,2] <- colnames(LEFT[i])
          out[k,3] <- difs$statistic
          out[k,4] <- difs$p.value
          out[k,5] <- corr$estimate
          out[k,6] <- corr$p.value
          k <- k + 1
          x = data2[,i]
          y = data2$geft
          plot(x, y, ylab = "GEFT score", xlab = colnames(data2[i]))
          abline(lm(y ~ x))
          readline(prompt="Press [enter] to continue")
          boxplot(data2[,i], main = colnames(data2[i]), notch = T)
          readline(prompt="Press [enter] to continue")
        }
      }
    }
  }
}

colnames(out) <- c("data-source", "hem-region-measure","T-stat","T-test(p-value)","Corr-Coefficient","Corr-test(p-value)")
write.csv(file = '../../results.csv', x = out)
