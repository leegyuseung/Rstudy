#iris dataset으로 다중회귀분석
str (iris)

cor(iris[, -5])
nrow(iris) #150개

# train / test split (학습데이터와 검증데이터로 분리해서 작업) 7:3
set.seed(12)
sam_tt <- sample(1:nrow(iris), nrow(iris)*0.7, replace=F) #비복원샘플링(표본추출)
NROW(sam_tt) #105개만 추출
train <- iris[sam_tt, ] # train data (모델 학습용)
test <- iris[-sam_tt, ] # test data (모델 검증용)
dim(train) #105 5
dim(test)  #45 5
head(train, 5)
head(test, 5)
?sample
# 모델 작성
model <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = train)
# 학습은 train data로 한다.
summary(model)

# 모델 충족 조건 확인이 필요하나 생략

par(mfrow=c(2,2))
plot(model)

#train으로 학습하고 train으로 검증하면 그 결과는 모델이 정상이라면 결과가 유사함
pred <- predict(model, train)
cat('실제 값:', train$Sepal.Length)
cat('예측 값:', round(pred,1))

#train으로 학습하고 test로 검증한 결과가 유사해야함. 
#그 차이가 크면 train data에만 최적화된 모델

pred2 <- predict(model, test) #검정은 test
cat('실제 값:', test$Sepal.Length)
cat('예측 값:', round(pred2,1))

summary(test$Sepal.Length)
summary(pred2)

cor(pred2, test$Sepal.Length)
