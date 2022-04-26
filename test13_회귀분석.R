#iris dataset으로 선형회귀 분석 : 상관관계와 회귀모델의 적합성

head(iris, 3)
cor(iris[, 1:4])
cor(iris[, -5])

# 연습1 : 상관관계가 약한 변수로 모델 작성
cor(iris$Sepal.Length, iris$Sepal.Width) #음의 상관관계가 약하다 #-0.1175698
model1 <- lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
summary(model1) # R-squared:  0.01382,  
#p-value: 0.1519> 0.05 이므로 적합한 모델이 아님
 
#연습2 : 상관관계가 강한 변수로 모델 작성
cor(iris$Sepal.Length, iris$Petal.Length) #0.8717538 양의 상관관계가 강함
plot(iris$Sepal.Length, iris$Petal.Length)

model2 <- lm(formula = Sepal.Length ~ Petal.Length, data = iris)
summary(model2) #  p-value: < 2.2e-16 < 0.05이므로 적합한 모델이다

#회귀분석모형의 적절성을 위한 조건을 충족해야 함
#...
