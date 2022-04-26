#mtcars dataset으로 단순/다중 선형회귀 분석 모델

head(mtcars)
str(mtcars)
dim(mtcars) #32행 11열

# 연습1 - 단순선형회귀
# 임의의 마력수(hp)를 입력하면 연비는 얼마일까? 이를 위한 모델 작성
# hp : 독립변수(연속형), mpg : 종속변수(연속형)

cor(mtcars$hp, mtcars$mpg) # r=-0.7761684이고 두 변수는 인과관계임

par(mar = c(1,1,1,1)) #마진을준다
plot(formula = mpg ~ hp, data=mtcars, xlab='hp', ylab='mpg')

model1 <- lm(formul = mpg~hp, data=mtcars)
model1
# y = -0.06823 * x + 30.09886

summary(model1) # p-value: 1.788e-07 < 0.05 유의한 모델, R-squared:  0.6024
abline(model1, col='blue')

#예측값 얻기
new_hp = 110
cat('예측값:',  -0.06823 * new_hp + 30.09886)

new_hp = 160
cat('예측값:',  -0.06823 * new_hp + 30.09886)

new_hp = 70
cat('예측값:',  -0.06823 * new_hp + 30.09886)

# predict() 함수 사용
mynew <- mtcars[c(1,2),]
mynew <- edit(mynew)
mynew
pred <- predict(model1, newdata = mynew)
cat('예측값:',pred)

# 연습2 - 다중선형회귀
# 임의의 마력수(hp)와 차체무게(wt)를 입력하면 연비는 얼마일까? 이를 위한 모델 작성
# hp, wt : 독립변수(연속형), mpg : 종속변수(연속형)

cor(mtcars$hp, mtcars$mpg) # -0.7761684
cor(mtcars$wt, mtcars$mpg) # -0.8676594

model2 <- lm(formula = mpg ~ hp + wt, data = mtcars)
model2
# y = -0.03177 * new_hp + -3.87783 * new_wt + 37.22727

#예측
new_hp <-  110; new_wt <-  2.62
cat('예측값:',  y = -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

new_hp <-  160; new_wt <-  5.62
cat('예측값:',  y = -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

new_hp <-  80; new_wt <-  1.0
cat('예측값:',  y = -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

#predict()
new_data <- data.frame(hp=110, wt=2.62)
predict(model2, newdata = new_data)

new_data <- data.frame(hp=160, wt=5.62)
predict(model2, newdata = new_data)
