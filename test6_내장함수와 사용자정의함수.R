# 내장함수와 사용자 정의 함수
# 주요 내장함수
seq(0, 5, by=1.5)
set.seed(123) #난수값 고정
rnorm(10, mean = 0, sd = 1) #정규분포를 따르는 난수발생
hist(rnorm(10000, mean = 0, sd = 1))
#분산 = 편차제곱의 합 나누기 자유도(전체갯수-1), 표준편차=루트분산

set.seed(1)
runif(10, min = 0, max = 100) #균등분포를 따르는 난수발생
hist(runif(50000, min = 0, max = 100))

sample(0:100, 10) #100개중 10개 추출, 비복원 추출

vec <- 1:10
min(vec)
max(vec)
mean(vec) #평균
median(vec) #중위수
var(vec) #분산
sd(vec) #표준편차
sum((vec - mean(vec))**2)/(length(vec)-1) #분산
sqrt(sum((vec - mean(vec))**2)/(length(vec)-1)) #표준편차
sd(vec) / mean(vec) #변동계수 = 표준편차/산술평균
prod(vec) #prod 곱 팩토리얼과 같은값
factorial(10)
table(vec) #빈도수
abs(-3) #절대값

getwd()

mean(iris$Sepal.Length)
sd(iris$Sepal.Length)

#...

# 사용자 정의 함수
func1 <- function(){
  print("사용자 정의 함수")
}

func1()

func2 <- function(arg1){
  print(arg1)
  return(arg1 + 100)
}

func2(10)

# 윤년체크 함수
yun_func <- function(y){
  if(y %% 4 == 0 & y %% 100 != 0 | y %% 400 == 0) {
    paste(y, '년은 윤년')
  }else{
    paste(y, '년은 평년')
  }
}

yun_func(2022)
yun_func(2020)
