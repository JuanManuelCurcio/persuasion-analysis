# 1. Introduction

###This notebook evaluates the relationship between the principal components identified in Part 2 and persuasion outcomes. Logistic regression models are ###fitted to assess whether component scores predict successful persuasion. Additional analyses are performed within specific participant clusters identified ###in Part 3

library(ResourceSelection)

# 2. Data Loading

dfstd <- read.table("data/PersuasionPART4_std.csv", sep = "," , header=TRUE)

# 3. Exploratory Visualization

varnum = dfstd[,5:10]
plot(varnum,col=c(rep("red",17),rep("blue",15)))

# 4. Logistic Regression on the Full Sample

M0 <- glm(dfstd$Impuso ~ dfstd$Comp.2, 
                    data = varnum, family = "binomial")

summary(M0)

rodds<- exp(coef(M0))
rodds

hoslem.test(dfstd$Impuso, fitted(M0))


# 5. Classification Performance
predictions <- ifelse(test = M0$fitted.values > 0.5, yes = 1, no = 0)
conf_matrix <- table(dfstd$Impuso, predictions,
                          dnn = c("observations", "predictions"))
conf_matrix

out <- 0
for (i in 1:nrow(varnum))
  out[i] <- predict(update(M0, data = varnum[-i,]), newdata = varnum[i,], type = "response")

mean((dfstd$Impuso - round(out))^2)


# 6. Cluster-Based Logistic Regression

## 6.1 Clusters 1 and 2
c1c2 <- subset(dfstd, pred_k %in% c(0, 1))
c1c2 <- c1c2[, 4:18]
c1c2 <- c1c2[, c(1, 2, 3, 4, 5, 6, 7, 10)]

M01 <- glm(Impuso ~ Comp.2, 
           data = c1c2, family = "binomial")

summary(M01)

rodds<- exp(coef(M01))
rodds

hoslem.test(c1c2$Impuso, fitted(M01))

# 6.2 Clusters 1 and 2 with Positive Component 2 Scores

c1 <- subset(dfstd, pred_k %in% c(0, 1))
c1 <- c1[, 4:18]
c1 <- c1[, c(1, 2, 3, 4, 5, 6, 7, 10)]
c1 <- subset(c1, Comp.2 >= 0)
M02 <- glm(Impuso ~ Comp.2, 
           data = c1, family = "binomial")

summary(M02)

rodds<- exp(coef(M02))
rodds

hoslem.test(c1$Impuso, fitted(M02))

# 7. Model Performance Within Clusters

## 7.1 Clusters 1 and 2
predictions <- ifelse(test = M01$fitted.values > 0.5, yes = 1, no = 0)
conf_matrix <- table(c1c2$Impuso, predictions,
                          dnn = c("observations", "predictions"))
conf_matrix


predict <- ifelse(M01$fitted.values > 0.5, 1, 0)

conf_matrix <- table(
  observations = c1c2$Impuso,
  predict = predict
)

conf_matrix

TN <- conf_matrix["0","0"]
FP <- conf_matrix["0","1"]
FN <- conf_matrix["1","0"]
TP <- conf_matrix["1","1"]

accuracy <- (TP + TN) / sum(conf_matrix)
precision <- TP / (TP + FP)
recall <- TP / (TP + FN)
f1_score <- 2 * precision * recall / (precision + recall)

accuracy
precision
recall
f1_score


# 7.2 Clusters 1 and 2 with Positive Component 2 Scores

predict <- ifelse(M02$fitted.values > 0.5, 1, 0)

conf_matrix <- table(
  observations = c1$Impuso,
  predict = predict
)

conf_matrix

conf_matrix

TN <- conf_matrix["0","0"]
FP <- conf_matrix["0","1"]
FN <- conf_matrix["1","0"]
TP <- conf_matrix["1","1"]

accuracy <- (TP + TN) / sum(conf_matrix)
precision <- TP / (TP + FP)
recall <- TP / (TP + FN)
f1_score <- 2 * precision * recall / (precision + recall)

accuracy
precision
recall
f1_score