# 선형회귀분석 모델 만들기
# y = wx + b 일차방정식을 작성하는데 이 것이 곧 선형회귀모델이다.
# w(기울기:slope), b(절편, bias)는 최소제곱법을 통해 얻을 수 있다.
# x(독립변수), y(종속변수) : x와 y는 원인과 결과의 관계를 갖는 변수이어야한다.

# 부모의 IQ : 110, 120, 130, 140, 150
# 자식의 IQ : 100, 105, 128, 115, 142

x <- c(110, 120, 130, 140, 150)
y <- c(100, 105, 128, 115, 142)
cor(x, y) #양의상관관계가 0.860744 매우강하다. 
#원인과 결과 관계? 있다라고 하면 선형회귀분석 시도.

plot(x, y)
#모델 작성 방법 1 : 직접 최소제곱법 수식을 사용
x_dev <- x - mean(x) #편차
y_dev <- y - mean(y)
dev_mul <- (x - mean(x)) * (y - mean(y))
square <- x_dev**2
df <-  data.frame(x, y, x_dev, y_dev, dev_mul, square)
df
mean(df$x) # 130
mean(df$y) # 118
sum(df$dev_mul) # 940
sum(df$square) # 1000
# y = wx + b
w = 940/1000
w # 기울기 0.94
b = 118 - 130 * 0.94 # b=mean(y)-(mean(x)*a)
b # 절편 -4.2

# y = 0.94*x + -4.2 선형회귀 모델 수식 완성
y = 0.94 * 110 + -4.2 # 부모의 iq = 110
y
print(0.94*120-4.2)
print(0.94*130-4.2)

#내가 알고 싶은 값?
print(0.94*88-4.2)
print(0.94*143-4.2)

#모델 작성 방법 2 : 제공된 수식을 사용
model <- lm(formula = y ~ x) # 내부적으로 최소제곱법을 사용해 w, b를 구함
model
predict(model)
abline(model, col='blue')

predict(model, data.frame(x=c(88,143)))

# 선형회귀 : 변수 간의 함수 관계를 파악하는 방법 중 하나로 독립변수가 
# 종속변수에 미치는 영향을 파악하고 이를 통해 독립변수의 일정한 값에 
# 대응하는 종속변수 값을 예측 (경향 예측, 추론, 추측)
# 모형산출 알고리즘이다
#---------------------------------------------
df2 <- data.frame(workhour = 1:7, totalpay = seq(10000, 70000, by = 10000))
df2 # 시간 당 급여액에 대한 회귀 분석
cor(df2$workhour, df2$totalpay) # 상관관계 1

plot(totalpay ~ workhour, data = df2)

model2 <- lm(formula = totalpay ~ workhour, data = df2)
model2
predict(model2)

grid()
abline(model2, col='blue', lwd=1) #lwd는 선굵기

# 미지의 시간당 급여액은?
predict(model2, data.frame(workhour = c(3.2, 8.8, 9)))
