#DataFrame : 데이터베이스의 테이블과 유사한 구조. 열단위로 타입이 다를 수 있다.

#1) vector로 data.Frame
no <- c(1,2,3) #벡터
name <- c('hong', 'lee', 'kim') #벡터
#df <-  data.frame(no, name)
df <-  data.frame(bunho = no, irum = name) #칼럼명을 부여
df #자동으로 인덱스가 따라 붙는다.
typeof(df) #list타입
df$bunho
df$irum

df <- data.frame(irum=c('james', 'oscar', 'tom'), nai=c(27,25,34), 
                 row.names = c('one','two','three')) #인덱스 값 변경해주기
df
head(df,2)
tail(df,2)
nrow(df) #행갯수
ncol(df) #열 갯수
str(df) #구조
summary(df)
names(df)

#2) matrix로 data.Frame
m <- matrix(c(1,'홍길동',170,2,'나길동',177,3,'신길동',187),3, by=T) # 3행3열
m
mdf <- data.frame(m) #dataframe
mdf

m <- matrix(1:6, nrow=3) #열우선 by=T 행우선
mdf <- data.frame(m)
mdf
colnames(mdf) <- c("c1","c2") #mdf 칼럼명 변경
mdf

mdf$c1 #벡터
mdf['c1'] #리스트
mdf[1]
mdf[-1]
mdf[1,2]
mdf[1:2,1:2]
mdf[1:2,c(1,2)]

mdf[mdf$c1 == 2,] #c1이 2인 행을 출력
subset(mdf, c1==2) #c1이 2인 행을 출력
?subset

mdf[mdf$c1 == 2 & mdf$c2 == 5, ]
subset(mdf, c1==2 & c2 == 5) # & > and

mdf[mdf$c1 == 2, c(1,2)] 
subset(mdf, c1==2, select = c(1,2)) 
#subset(mdf, select = c(2)) #2열만 선택 

mdf
mdf$c2 <- ifelse(mdf$c2==4, NA, mdf$c2)  #NA 넣기
mdf

summary(mdf)

mean(mdf$c2) #C2에 NA가 껴있어서 평균 못구한다.
mean(mdf$c2, na.rm = T) # na를 제외하고 평균을 계산한다.

#행 또는 열 추가
mdf
mdfr <- rbind(mdf, c(10,11)) #행추가
mdfr
mdfc <- cbind(mdf, c3 = c("a","b","c"), c4 = c("a1","a2","a3")) #열추가
mdfc

mdfc[, 'c3'] <- NULL #열삭제
mdfc

mdfr <- mdfr[-1, ] #1행을 제외한 나머지를 취한다 > 1행만 지워진 형태
mdfr

# 기본 데이터세트 읽기
data('iris', package = 'datasets')
head(iris)
typeof(iris)
is(iris)

#merge : 데이터프레임 병합
height <- data.frame(id=c(1,2,2), h=c(180,175,178))
weight <- data.frame(id=c(1,2,3), h=c(80,75,88))
height
weight
merge(height, weight, by.x = "id", by.y = "id")

sid <- c(100, 110, 120, 130)
score <- c(90, 85, 70, 65)
gender <- c("M", "F", "M", "F")
major <- c("경영","교육","컴공","사회")
student <- data.frame(sid, score, gender, major)
student

str(student)
plot(student$score)

# 조건에 맞는 부분 자료 얻기
subset(student, score >= 70)
subset(student, subset = (score >= 70))
subset(student, score >= 70 & gender == 'M')
subset(student, select=c(sid,gender))
subset(student, select=c(-sid,-gender))
subset(student, select=c(sid,gender), score<=80)
