#다중선형회귀분석(Multiple Linear Regression) : 독립변수가 복수
state.x77 #미국 각 주 관련 정보 dataset
str(state.x77)
class(state.x77)
colnames(state.x77)

# Murder(살인사건발생률)과 관련이 있는 변수만 추출해서 data.frame 작성
states <- as.data.frame(state.x77[,c('Murder','Population','Illiteracy','Income','Frost')])
head(states, 3)
dim(states) #50 5
cor(states)
# 독립변수 : Population, Illiteracy, Income, Frost
# 종속변수 : Murder

#모델 작성
mfit <- lm(formula = Murder ~ Population+Illiteracy+Income+Frost, data = states)
summary(mfit) # p-value: 9.133e-08 < 0.05 이므로 유의한 모델 
#독립변수가 2개이상이면 수정된 결정계수로 본다 Adjusted R-squared:  0.5285 

# 새 값으로 예측
part_states <- states[1:3,]
pre_states <- edit(part_states)
pre_states
predict(mfit, pre_states)
#--------------------------------

#회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
#1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
#2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
#3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
#4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
#5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.
par(mfrow = c(2, 2))
plot(mfit)
# 편차 : 평균과 실제값의 차이 잔차 : 2개의 변수 추세선 예측값과 실제값 차이

# 1) 잔차의 정규성
shapiro.test(residuals((mfit))) #p-value = 0.6672 > 0.05 정규성 만족

# 2) 독립성 검정
install.packages("car")
library(car)
durbinWatsonTest(mfit) #D-W Statistic  2.317691 : 2에 가까울수록 독립성 만족

# 3) 선형성 검정 MLE = 가능도, 우도
boxTidwell(Murder ~ Population+Illiteracy, data = states)
# Population       0.86939             -0.3228   0.7468 > 0.05 선형성 만족
# Illiteracy       1.35812              0.6194   0.5357 > 0.05 선형성 만족

# 4) 등분산성 검정
ncvTest(mfit) # p=0.18632 > 0.05 이므로 만족

# 5) 다중공선성 검정 : 분산 팽창 요인(vif()) 
#값이 10을 초과하면 다중공선성이 발생했다고 본다 
vif(mfit)
# Population Illiteracy     Income      Frost 
# 1.245282   2.165848   1.345822   2.082547 

#---------------------------------------------------------
#예측(독립, 설명)변수 선택 : 분석가에 입장에서 가장 고민해야할 문제 중 하나
mfit1 <- lm(Murder ~ ., data=states)
summary(mfit1) #Income, Frost 변수는 의미없는 변수일 가능성이 높음

mfit2 <- lm(Murder ~ Population + Illiteracy, data = states)
summary(mfit2)
# Adjusted R-squared:  0.5484 

#AIC 통계량 : 통계 모델간의 성능을 비교할때 사용한다 (낮을수록 좋은성능)
AIC(mfit1, mfit2)
# df      AIC
# mfit1  6 241.6429
# mfit2  4 237.6565 AIC 낮은 mfit2 모델이 더 좋다라고 평가됨

# AIC를 자동으로 처리하기 : stepwise regression
# 후진 소거법 : backward - 모든 변수를 넣고 기여도가 
# 낮은 변수부터 하나씩 제거하며 AIC를 체크
full_model <- lm(Murder ~ ., data=states)
reduce_model <-  step(full_model, direction = "backward")
summary(reduce_model)

# 전진 선택법 : forward - 유익한 변수부터 하나씩
# 추가하며 AIC를 체크한다.
min_model <- lm(Murder ~ 1, data=states)
fwd_model <-  step(min_model, direction = "forward", 
                   scope = ( Murder ~ Population+Illiteracy+Income+Frost),
                   trace = 1 )
summary(fwd_model)
# 위의 방법은 일반적이나, 기회를 갖지 못하는 변수가 있을 수 있다는 단점!

# all subset regression : 모든 조합에 대한 검증을 함
install.packages("leaps")
library(leaps)
model <- leaps::regsubsets(Murder ~ Population+Illiteracy+Income+Frost, 
                           data=states,
                           nbest = 4)
summary(model)
summary(model)$bic
summary(model)$adjr2

plot(model,scale="bic")

