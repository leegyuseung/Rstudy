# Logistic Regression
# 독립변수 : 연속형, 종속변수 : 범주형
# 종속변수와 독립변수 간의 관계를 통해서 분류 모델을 생성
# 분류결과는 이항분포를 따른다. 출력범위가 0 ~ 1 사이가 됌.
# 출력을 위해 로지스틱함수(시그모이드 함수)를 사용한다.
# 예: 생존/사망, 고객 부도 여부, 최종학력 등 범주형으로 결과를 분류하고자 할 때 사용

#시험성적, 내신성적, 순위에 따른 대학원 합격여부 데이터로 분류 모델 작성
mydata <- read.csv("testdata/binary.csv")
head(mydata, 3)
str(mydata)

#독립변수 : gre gpa rank(연속형), 종속변수 : admit(범주형)
summary(mydata) #데이터의 분포 확인

# admit, rank 변수로 빈도표
xtabs(formula = ~admit+rank, data=mydata)

table(mydata$admit, mydata$rank)

# 분류 모델 작성
# train / test 분리 (7:3) : 모델의 과적합(overfitting) 방지가 목적
set.seed(42)
idx <- sample(1:nrow(mydata), nrow(mydata) * 0.7)
train <- mydata[idx,]
test <- mydata[-idx,]
dim(train) #280 4
dim(test) #120 4
head(train, 3)
head(test, 3)

# 로지스틱 회귀모델은 일반화된 선형회귀 모델
#model <-  lm(formula = admit ~., data=train) #선형회귀모델
lgmodel <- glm(formula = admit~., data=train, family = binomial(link='logit'))
lgmodel
summary(lgmodel)

#예측
pred <- predict(lgmodel, newdata = test, type="response") #학습 train 검증은 test
pred
#cat('예측값:',head(pred,10))
cat('실제값:',head(test$admit, 10))
cat('예측값:',head(ifelse(pred>0.5, 1,0),10))

#분류 정확도 계산
result_pred <- ifelse(pred>0.5,1,0)
t <- table(result_pred, test$admit) #예측값, 실제값을 넣는다
t
(80 + 9) / nrow(test) # 0.7416667 74.1% 분류정확도(accuracy)
(t[1,1] + t[2,2]) / nrow(test)
sum(diag(t)) /nrow(test)

# 새로운 값으로 분류하기
new_data <-  train[c(1:3),]
new_data <- edit(new_data)
new_pred <- predict(lgmodel, newdata = new_data, type="response")
new_pred
ifelse(new_pred > 0.5, 'admit','deny')
