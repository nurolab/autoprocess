setwd('/home/deep/Documents/Morphometrical_analysis_for_CD')
data <- read.csv(file = 'qdec_no_outlier.csv', sep = ',', header = T)

data$lh_middletemporal_thickness <- demean(data$lh_middletemporal_thickness)
data$lh_supramarginal_thickness <- demean(data$lh_supramarginal_thickness)
data$geft <- demean(data$geft)

cor.test(data$geft,data$lh_supramarginal_thickness)
cor.test(data$geft, data$lh_middletemporal_thickness)

plot(data$geft,data$lh_middletemporal_thickness)
plot(data$geft, data$lh_supramarginal_thickness)

t.test(data$lh_middletemporal_thickness[1:26], data$lh_middletemporal_thickness[27:47])
t.test(data$lh_supramarginal_thickness[1:26], data$lh_supramarginal_thickness[27:47])

plot(data$lh_middletemporal_thickness)

write.csv(file = 'qdec_no_outlier.csv', x = data)
