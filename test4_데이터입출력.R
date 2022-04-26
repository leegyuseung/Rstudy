#데이터 입출력
n <- scan() # 키보드로 자료 입력
sum(1:n)

ss <- scan(what="") #문자열 입력
ss 

df <-  data.frame()
df <-  edit(df)
df

# 파일 읽기
student <-read.table("testdata/student.txt")
student
is(student)

student2 <-read.table("testdata/student2.txt", sep=";", header = TRUE)# skip=2
student2 #skip=2 2개행만읽기, header= 칼럼명 들어가기기

student3 <-read.table("testdata/student3.txt", sep=" ", header = TRUE, na.strings = '-')
student3  #na.string='-' -를 NA값으로 대체

student4 <-read.table("testdata/student4.txt", sep=",", header = TRUE, na.strings = '-')
student4  

student5 <-read.csv("testdata/student4.txt", header = TRUE, na.strings = '-')
student5  #,는 csv로 읽으면된다.

install.packages("xlsx") #설치
library(xlsx)
student6 <- read.xlsx(file="testdata/student.xlsx", sheetIndex = 1, encoding = 'UTF-8')
student6  #,는 csv로 읽으면된다.

#--------------------------------------------------------
# 데이터 출력
x <- 10; y <- 20; z <- x * y 
cat("결과는 ", z, '입니다')
print(z) #프린트는 z값만 출력가능

cat(x,y,z)
print(x,y,z) #하나만찍을수있다.

#파일로 출력
name <- c("관우","장비","유비")
age <- c(35, 33, 25)
gender <- c("남","남","여")
myframe <-  data.frame(name, age, gender)
myframe

write.table(myframe, "output/my1.txt", fileEncoding = "UTF-8") #output폴더에 만들기
write.table(myframe, "output/my2.txt", row.names = TRUE, fileEncoding = "UTF-8") 
write.table(myframe, "output/my3.txt", row.names = FALSE, fileEncoding = "UTF-8") 
write.table(myframe, "output/my4.txt", row.names = FALSE, quote=F, fileEncoding = "UTF-8") 
#따옴표 x
#read.table("output/my3.txt") #읽을수 있다.
write.csv(myframe,"output/my5.csv", quote=F, row.names=FALSE,  fileEncoding = "UTF-8")
write.xlsx(myframe,"output/my6.xlsx", sheetName = 'sheet1')

#---------------------------------------------------------
# 돗수분포표
df <- read.csv("testdata/ex_studentlist.csv")
df
str(df)
summary(df)

# 명목형 자료로 돗수분포표 : gender, bloodtype
freq <- table(df$gender, df$bloodtype)
freq <- table(df$gender) #하나만 구하기
freq #빈도수를 구할 수 있다.

rfreq <- prop.table(freq)
rfreq #상대도수, 비율로 나온다

rtable <- rbind(freq, rfreq)
rtable #테이블에 빈도수와 비율로 보이기

rtable <- addmargins(rtable, margin = 1) #margin=1열의합, 2행의합 
rtable #소계가 들어간다.
