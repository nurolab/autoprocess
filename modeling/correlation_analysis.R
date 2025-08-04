# This script performs bonferroni corrected statistical analysis between two variables

data <- morph_vars
x <- data$var1
y <- data$var2

cor.test(x,y) # Correlation analysis
plot(x,y)
t.test(x,y,p.adjust = "bonferroni") # Multiple coparison correction
lmodel <- lm(formula = y~x) # Linear modeling
abline(lmodel)
