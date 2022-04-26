# 시각화(그래프 출력)
# 이산변수 : 막대, 원형, 점 ...
# 연속변수 : 상자박스, 히스토그램, 산점도 ...

stu <- read.csv("testdata/ex_studentlist.csv")
head(stu, 3)

stu$grade
table(stu$grade)

barplot(stu$grade) #막대 그래프
? barplot
barplot(stu$grade, ylim=c(0,5), col = rainbow(5), main='차트제목') 
#col = 칼라, ylim y의 범위 #main = 차트제목
barplot(stu$grade, ylab="학생", xlab="학년", 
        col = rainbow(3), main='차트제목', horiz=T) 
#horiz=T 는 세로막대 , ylab과 xlab은 가로 세로 이름

par(mfrow = c(1,2)) #mf row 1행 2열이 된다
barplot(stu$grade, col=c(3,4,5))
barplot(stu[, 4], col=rainbow(4), space=2) #space는 막대의 간격격

par(mfrow = c(1,1))
# 점
dotchart(stu$grade)
dotchart(stu$grade, color = 2:5, lcolor = "black", pch = 1:2, cex=1.5)
#lcolor = 라인칼라 pch = 모양 cex= 점크기

#파이
str(stu)
df <- na.omit(stu) #결측값(NA)은 빼고 나머지
str(df)
pie(df$age)
pie(df$age, labels = df$age, lty = 3)
# lty = 라인스타일
?pie # 옵션보기

# 상자박스 : boxplot
mean(stu$height)
median(stu$height)
quantile(stu$height)

boxplot(stu$height) #최대값 최소값 이상치값 등의 위치를 볼 수 있다.
boxplot(stu$height, range=0)
boxplot(stu$height, range=1) #range= 최대,최소값을 선으로 연결할것인가
boxplot(stu$height, range=1, notch = T)
abline(h=170, lty=3, col="blue" ) #170에 수평선을 둔다

# 히스토그램 : hist
hist(stu$height)
hist(stu$height, breaks=2) # breaks = 막대간격 조절
hist(stu$height, prob=T) # prob = T 밀도로 나온다
lines(density(stu$height))

hist(stu$height, xlab = "키", main="히스토그램", xlim=c(150, 200), col="yellow")
# xlim= limit

#산점도
price <- runif(10, min=1, max=100)
plot(price)
par(mfrow=c(2,2))
plot(price, type='l')
plot(price, type='o')
plot(price, type='h')
plot(price, type='s')
? plot

# 3차원 산점도 그래프 ---
install.packages("scatterplot3d")
library("scatterplot3d") 

par(mfrow=c(1,1))
# 붓꽃의 종류별 분류로 3차원 그래프 그리기
levels(iris$Species) 
iris
ir.setosa = iris[iris$Species=='setosa', ]
ir.virginica = iris[iris$Species=='virginica', ]
ir.versicolor = iris[iris$Species=='versicolor', ]

# 형식 : scatterplot3d( 밑변，우변칼럼명，좌변칼럼명，type) 
# 틀 생성
irdata <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type = 'n')

# 산점도 시각화
irdata$points3d(ir.setosa$Petal.Length, ir.setosa$Sepal.Length, 
                ir.setosa$Sepal.Width, bg='red', pch=21)

irdata$points3d(ir.virginica$Petal.Length, ir.virginica$Sepal.Length, 
                ir.virginica$Sepal.Width, bg='blue', pch=23)

irdata$points3d(ir.versicolor$Petal.Length, ir.versicolor$Sepal.Length, 
                ir.versicolor$Sepal.Width, bg='yellow', pch=25)


# ggplot2 package : 그래프 기능이 확장된 패키지(라이브러리)
library(ggplot2)
head(mpg,3)
?ggplot #옵션값이 복잡하다
ggplot(data=mpg, aes(x=displ))#속성값을 주는게 어렵다
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

install.packages("dplyr")
library(dplyr)
df_mpg <- mpg %>% group_by (drv) %>% summarise(mean_hwy = mean(hwy)) 
# %>% 명령을 이어쓸수있다.
df_mpg

ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x=drv, y=hwy)) + geom_boxplot()
