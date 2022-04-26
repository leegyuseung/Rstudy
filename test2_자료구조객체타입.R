# R의 자료 구조(객체 타입) 
# Vector, Matrix, Array, List, DataFrame

#1. Vector : 1차원 배열 형태의 자료구조
year <- 2022
is(year)
year <- "2022"
is(year) #타입확인
year[1]
is.vector(year) #벡터가 맞는지 확인

# 벡터 수열
#seq(from, to, by) seq(start, stop, step)
seq(1,5)
1:5
seq(1,10,2)
seq(1,10,length.out = 4) #전체수열의개수를적음

rep(1:3, 3) #1~3까지 3번반복해
rep(seq(1,3),3) #rep안에 seq을 넣기 가능하다
rep(1:3, each=3) #각각 3번씩 반복
rep(1:2, each=5, times=2) #1~2까지 각각 5번반복을 2번한다

c(1, 2, 5, -3, 10, 10:15) #중복도 허용한다
aa <- c(1:10) #combine 함수
aa

c(22, -5.7, '문자열') #전체가 문자열
c(22, -5.7) #전체가 실수
c(1, 2.5, T, F) # TRUE는 1.0 FALSE는 0.0

age <- c(10,20,30)
age
age[1] #10
age[3] #30
age[4] #NA
age <- c(age, 40)
age
age[10] <- 50 #총 10자리확보 마지막 50이 들어간다.
age
age <- append(age,60,after=6) #6번째 뒤에 60이 채워진다.
age
age <-NULL #NULL이 들어간다
age #아무것도 안나온다.

v1 <- c(13, -5, 20:23, 12, -2:3)
v1
v1[1]
v1[1:5]
v1[c(2, 4, 4:7)]
v1[-c(2, 3)] # -를 붙이면 여집합이 된다.
v1[1,2] #다차원을 의미라 쓰면안된다 #Error incorrect number of dimensions
13 %in% v1 #있으면 TRUE, 벡터에 포함된 값 유무 확인
11 %in% v1 #없으면 FALSE

nrow(v1) #건수확인 : 행렬에서만 가능
NROW(v1) #건수확인 : 행렬, 벡터 가능

a <- 1:3
b <- 4:6
a
b
a + b #각 위치끼리 더한다.
a * b #각 자리끼리 곱한다.
a / b
a + 10
a[4] <- 2

union(a,b) #벡터 결합 : 합집합, 중복X
c(a,b) # 벡터 결합 : 합집합,  중복O
setdiff(a,b) # 차집합
b[4] <-  2
intersect(a,b) # 교집합

# -------------------------------------------------------
# matrix : 2차원 배열, 행렬 구조. 현대 수학에서는 행렬이 대세
a <- 1:8 #벡터
dim(a) <- c(2, 4) # 매트릭스 생성 (2행4열)
a
dim(a) # 매트릭스 차원, 구조 확인
is(a)
class(a)
mode(a)     

m <- matrix(1:5) # 5행 1열 주로 많이 사용한다.
m
dim(m)

m <- matrix(1:9, nrow = 3) # 3행3열짜리 매트릭스 #열부터채우기 N자모양 
m
dim(m)

m <- matrix(1:9, nrow = 3, byrow = T) # Z형식으로 채우기 
m
dim(m)

m <- matrix(1:10, 2) #nrow는 생략가능
m

m <- matrix(1:10, 3) #warning이 붙는다 error는 아니다
m

m[1, ] # 1행만 보기
m[, 3] # 3열만 보기
m[2,3] # 2행 3열 값만 보기
m[1,c(2:4)] # 1행의 2~4열
m[1:2,c(2:4)] # 1~2행의 2~4열
m[-1, ] # 1행만 빼고
m[, -3] # 3열만 빼고
m[-1,-1]

a <- matrix(c(1:9), nrow=3, ncol=3)
rownames(a) <- c('r1', 'r2', 'r3') # row 이름부여
colnames(a) <- c('one', 'two', 'three') #col 이름부여
a
a['r1',] #이름으로 보기
ncol(a)
nrow(a)
dim(a)

#matrix 계산
a <- matrix(c(1,2,3,4),2,2)
a
b <- matrix(5:8, 2)
b

a+b
a*b #아다마르곱
a %*% b #행렬곱

diag(a) #주 대각 요소 출력
t(a) #전치

x1 <- c(5,40,50:52)
x1
x2 <- c(30, 5, 6:8)
x2
rbind(x1,x2) #행으로 묶인다
cbind(x1,x2) #열로 묶인다.

#함수를 실행한는 함수
#apply() # lapply(), sapply(), tapply()
x <- matrix(1:9, 3)
x
apply(x, 1, max) # 1: 행기준
apply(x, 2, max) # 2: 열기준준
apply(x, 1, mean)

func <- function(x){
  x + c (5, 10, 15)
}

apply(x, 1, func) # 사용자 정의 함수를 실행

head(iris,2)
apply(iris[,1:4],2,mean)

#-------------------------------------------------
# array : 다차원 배열 - 행, 열, 면을 갖는 3차원 자료구조를 취할 수 있다.
d <- c(1:12) #벡터
is(d)
arr1 <- array(d) #벡터를 array처리
arr1
dim(arr1)
is(arr1)

arr2 <- array(1:12, dim= c(6,2)) 
arr2
dim(arr2)
 
arr3 <- array(1:12, dim= c(3,2,2))  #3행 2열 2면
arr3
dim(arr3)

#---------------------------------------------------
# list : 서로 다른 타입의 데이터 자료구조.
# (키,값)형태의 데이터를 담는 연관 배열 
li <- list("1","홍길동",22,"2","고길동",32) #묶기
li
unli <- unlist(li) #묶인걸 푸는방법
unli

num <- list(c(1:5), c(6:10), c("a","b","c"))
num
num[1]
typeof(num[1]) #list
typeof(num[[1]]) #integer 리스트안의 value값을 꺼낸것

num2 <- list(x=1:5, y=6:10) #$ 키를 따로 준것
num2
num2$x
num2$y
