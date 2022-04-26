va <- 1
va <- 2
va = 3
4 -> va
cat('결과는',va)
print(va)
a <- 2
b <- 3

# 데이터 유형 
kbs <- 9 #scalar는 지원x, 기본vector
object.size(kbs)
typeof(kbs)
typeof(3)
typeof(3.14) #R은 숫자는 double
is(kbs) # 데이터 유형 출력
mbc <- as.integer(kbs) #형변환
is(kbs)
typeof(kbs)
mbc <- 9L
is(mbc)

ss <- '홍길동'
typeof(ss)
is(ss)
ss[1]

b <- TRUE
is(b)
b <- T

#vector 가 기본 값 : character, logical, numeric(integer)
typeof(NA)
aa <- NA # 결측데이터(값이 입력되지 않은 상태)
aa
is(aa)

sum(2,3)
sum(2,3, NA) #결측값이 있으면 전체가 NA가 된다.
sum(2,3, NA, na.rm = T) #na는 remove하고 작업해라.

typeof(NULL) #데이터 값이 없음. 값으로 인식X
sum(2,3,NULL) #값으로 인식안되서 무시한다.

typeof(NaN) #수학적으로 정의되지 않은 값
sum(2,3,NaN) #값으로 인식해 연산을 방해한다.

typeof(Inf)
0/0
0*Inf
Inf-Inf

length(NA)
length(NaN)
length(NULL)

z <- 5.3 - 3i
z
is(z)

f <- function(){ #function에서 ctrl+enter해야된다.
  return('good')
  
}
f()
is(f)
typeof(f)

#x <- 123.4 # numeric double
#x <- "123" #character
x <- FALSE #logical
cat(mode(x), class(x), typeof(x))

ls() #현재 사용중인 객체 목록
ls.str()

rm(aa) #변수 삭제
rm(list=ls()) #사용중 개체 전부 삭제


# ----------------------------------
# package : 데이터 + 함수 + 알고리즘 꾸러미
available.packages() #현재 적용된 패키지 목록
dim(available.packages())

install.packages("plyr") #다운
library(plyr) #로딩
ls("package:plyr") #목록보기
data(package="plyr")
baseball

remove.packages("plyr") #지우기

#기본 dataset : 연습용 dataset이 제공
data()

head(Nile)
tail(Nile,3)

hist(Nile, freq = F) #Histogram 볼수있다.
lines(density(Nile)) #밀도차트도 라인으로 같이보기기

help("hist")
?"hist"
?mean

x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x,trim = 0.10 ))

getwd()


head(iris, 3) #꽃의 종류를 구별
#이미지분류 mnist 
