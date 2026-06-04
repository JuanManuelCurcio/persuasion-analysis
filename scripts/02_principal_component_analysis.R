# 1. Introduction
###This notebook performs a Principal Component Analysis (PCA) on the linguistic variables extracted in Part 1. The objective is to reduce the dimensionality of ###the dataset, identify underlying patterns among linguistic features, and generate component scores that will be used for cluster analysis in Part 3.

library(corrplot)

# 2. Data Loading
# Read the file
df <- read.csv("data/PersuasionPART2_numeric.csv",sep = "," , header=TRUE)
View(df)
# 3. Outcome recoding
## 2 = persuaded partner
## 1 = did not persuade partner
df$Impuso_n[df$Impuso==1]<- 2
df$Impuso_n[df$Impuso==0]<- 1

# 4. Correlation Analysis

# Correlation matrix
matr<- cor(df[,4:9])
matr
round(cor(df[,4:9]),2)

# Correlation matrix plot
corrplot(matr, method = "circle",order = "hclust",addrect = 2)

# 5. Principal Component Analysis

pca_model<-princomp(df[,4:9], cor=TRUE,scores=TRUE)
summary(pca_model)
plot(pca_model,ylim=c(0,3))
par(mar = c(5, 4, 4, 2) + 0.1)
plot(pca_model, ylim = c(0, 4))
loadings <- pca_model$loadings
loadings

# 6. Component Interpretation

# Correlation between principal components and original variables
# Used to interpret the meaning of each component
rxcp<- cor(df[,4:9],pca_model$scores)
rxcp
corrplot(rxcp,method="circle")
corrplot(rxcp,method="number")

# 7. Participant Representation in PCA Space

# Principal component scores for each participant
pca_scores<-pca_model$scores
biplot(pca_model)


# Participant scores on the first two principal components
plot(pca_scores[, c(1, 2)], type = "n")
text(x=pca_scores[,1],y=pca_scores[,2],col=c("blue","red")[df$Impuso_n])
abline(h=0)
abline(v=0)
legend(x = "topright",cex=0.8,legend = c("Persuader", "Persuaded"), fill = c("red","blue"))

# 8. Group Centroids

df_centroids <- cbind(df[,10], pca_scores[, c(1, 2)])

# Calculate group centroids in the PCA space
centrocp1<- cbind(1,mean(df_centroids[df_centroids[,1]=="1",2]),mean(df_centroids[df_centroids[,1]=="1",3]))
centrocp2<- cbind(2,mean(df_centroids[df_centroids[,1]=="2",2]),mean(df_centroids[df_centroids[,1]=="2",3]))

#adding centroids to the original df
dfplotcent<-rbind(df_centroids,centrocp1,centrocp2)
View(dfplotcent)
plot(dfplotcent[50:51,2:3],type="n",ylim = c(-2.5,2.5),xlim=c(-3.5,3.5))
text(x=dfplotcent[50:51,2],y=dfplotcent[50:51,3],col=c("blue","red")[dfplotcent[50:51,1]])
abline(h=0)
abline(v=0)
legend(x = "topright",cex=0.7,legend = c("Persuaded", "Persuader"), fill = c("Blue", "Red"))

# 9. Group Comparisons

# Comparing principal component scores between persuasion outcomes
t.test(pca_model[["scores"]][,1]~ df$Impuso_n,alt="two.sided",conf.level = 0.95)

t.test(pca_model[["scores"]][,2]~ df$Impuso_n,alt="two.sided",conf.level = 0.95)

t.test(pca_model[["scores"]][,3]~ df$Impuso_n,alt="two.sided",conf.level = 0.95)

# 10. Dataset Export
dfpart3 <- cbind(df,pca_scores)

# Export PCA scores for clustering analysis performed in Part 3
write.csv(dfpart3,"data/PersuasionPART3_pca.csv",row.names = FALSE)