# Logistic Regression
# 날씨 정보를 읽어 내일 비 유무 판단하기
weather <- read.csv("testdata/weather.csv")
head(weather,3)
dim(weather) #366 15
str(weather)
summary(weather)
colnames(weather)

weather_df <- weather[, c(-1, -6, -8, -14)]
head(weather_df,3)
str(weather_df)

summary(weather_df)
weather_df[!complete.cases(weather_df),] #NA가 있는 행 찾기
sum(is.na(weather_df)) #NA 갯수 확인
weather_df <- na.omit(weather_df)

unique(weather_df$RainTomorrow) # "Yes" "No" 

# RainTommorw 변수를 더미(dummy)변수화
weather_df$RainTomorrow[weather_df$RainTomorrow=='Yes'] <- 1
weather_df$RainTomorrow[weather_df$RainTomorrow=='No'] <- 0
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow) #numeric변경해줌
head(weather_df,3)
str(weather_df)

# train / test
dim(weather_df) # 366 11
set.seed(12)
idx <- sample(1:nrow(weather_df), nrow(weather_df)*0.7)
train <- weather_df[idx,] 
test <-  weather_df[-idx,] 
dim(train); dim(test) # 252, 11 / 109, 11

#model
weather_model <- glm(RainTomorrow ~., data = train, family = 'binomial')
weather_model
summary(weather_model)

#예측
pred <- predict(weather_model, newdata = test, type = 'response')
head(pred, 10)

result_pred <- ifelse(pred >= 0.5, 1, 0)
result_pred

table(result_pred)
table(result_pred, useNA= 'ifany') #NA도 결과에 참여

# confusion matrix
t <- table(result_pred, test$RainTomorrow)
t
# 분류모델의 정확도
sum(diag(t)) / nrow(test) # 0.8807339

# 분류모델의 평가 : ROC curve
# ROC(Receiver Operating Characteristic) curve는 다양한 threshold에 대한 이진분류기의 성능을 한번에 표시한 것이다.
# 이진 분류의 성능은 True Positive Rate와 False Positive Rate 두 가지를 이용해서 표현하게 된다.
# ROC curve를 한 마디로 이야기하자면 ROC 커브는 좌상단에 붙어있는 커브가 더 좋은 분류기를 의미한다고 생각할 수 있다.

install.packages('ROCR')
library(ROCR)

summary(pred)
pr <- prediction(pred, test$RainTomorrow)
pr
prf <-  performance(pr, measure='tpr', x.measure='fpr')
plot(prf)
# 커브 선이 왼쪽 상단에 가까울수록 좋은 모델이다.

# AUC
# AUC (Area Under the ROC Curve)는 ROC curve의 밑면적을 말한다. 
# 즉, 성능 평가에 있어서 수치적인 기준이 될 수 있는 값으로, 
# 1에 가까울수록 그래프가 좌상단에 근접하게 되므로 좋은 모델이라고 할 수 있다.
# AUC의 기준은 아래와 같다. 
# 0.90-1 = excellent
# 0.80-0.90 = good 
# 0.70-0.80 = fair 
# 0.60-0.70 = poor
# 0.50-0.60 = fail

auc <-  performance(pr, measure='auc')
auc <-  auc@y.values
auc[[1]] # 0.8918495 good model

# 새 값으로 예측
new_data <- train[c(1:3),]
new_data <- edit(new_data)
new_pred <- predict(weather_model, newdat = new_data, type='response')
ifelse(new_pred > 0.5, '비', '맑음')
