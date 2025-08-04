demean <- function(x){
  if (is.vector(x))
    return(x-mean(x))
  
  # apply(x,2,demean)
}
data <- read.csv(file = 'qdec.data.csv', header = T, sep = ',')
View(data)

data$gender <- demean(data$gender)
data$age <- demean(data$age)
data$EstimatedTotalIntraCranialVol <- demean(data$EstimatedTotalIntraCranialVol)

boxplot(data$gender)
boxplot(data$age)
boxplot(data$geft)
boxplot(data$EstimatedTotalIntraCranialVol)

data <- data[-35,]
write.csv(file = 'qdec_no_outlier.csv', x = data)
