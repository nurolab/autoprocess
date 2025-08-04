
#make this example reproducible 
# set.seed(1)
df <- read.csv(file = 'qdec.table.dat', sep = ' ', header = T)
#create data frame with three columns A', 'B', 'C' 
# df <- data.frame(A=rnorm(1000, mean=500, sd=10),
#                  B=rnorm(1000, mean=500, sd=20),
#                  C=rnorm(1000, mean=1500, sd=50))
# 
# #view first six rows of data frame
# head(df)


#find absolute value of z-score for each value in each column
z_scores <- as.data.frame(sapply(df$EstimatedTotalIntraCranialVol, function(df) (abs(df-mean(df))/sd(df))))

# #view first six rows of z_scores data frame
# head(z_scores)
# 

#only keep rows in dataframe with all z-scores less than absolute value of 3 
no_outliers <- z_scores[!rowSums(z_scores>3), ]

#view row and column count of new data frame
dim(no_outliers)

#find Q1, Q3, and interquartile range for values in column A
Q1 <- quantile(df$EstimatedTotalIntraCranialVol, .25)
Q3 <- quantile(df$EstimatedTotalIntraCranialVol, .75)
IQR <- IQR(df$EstimatedTotalIntraCranialVol)

#only keep rows in dataframe that have values within 1.5*IQR of Q1 and Q3
no_outliers <- subset(df, df$EstimatedTotalIntraCranialVol> (Q1 - 1.5*IQR) & df$EstimatedTotalIntraCranialVol< (Q3 + 1.5*IQR))

#view row and column count of new data frame
dim(no_outliers) 
plot(df)

