# # df1 <- data.frame(
# #     roll_no=c(1, 2, 3),
# #     name=c('Amit', 'Neha', 'Ravi'),
# #     marks=c(20, 12, 98)
# # )
# # print(df1)

# df1<-data.frame(
#   roll_no=c(1,2,3),
#   name=c("Amit","Neha","Ravi"),
#   marks=c(78,85,90)
# )
# print(df1)

# #1
# natural_numbers <- 1:10
# print(natural_numbers)

# #2
# v<-c("AI","ML","Data Science","Big Data")
# length(v)

# #3
# v<-c(5,10,15,20,25)
# print(v[1])
# print(v[length(v)])

# #5	
# v<-c(12, 14, 54, 32, 23)
# v[v>40]
# length(v[v<50])

# #8
# v<- c(10, 20, NA, 20, 50)
# # sum(v, na.rm= TRUE)
# # sum(v)

#9
# v<-c(35, 55, 75, 40, 90)
# ifelse(v>50, 'pass', 'fail')

# v1<-c(math=85, phy=78, chem=92)
# v1$phy


# no<-c(0:20)
# no[c(no %% 2 == 0)]

# v3<-c(10, 20, 30, 40 ,50)
# v3[3]<- 100
# print(v3)


#names<-c('Mridul', 'Jay', 'Gantavya')
#sort(names)


x <-c(10, 20, 30, 40)
sum(x)
max(x)
mean(x)
min(x)

median(x)
var(x)
sd(x)


si <- function(p, r=5, t=2) {
  return((p*r*t) /100)
}

avg <- function(vec) {
  mean(vec)
}

si(10, 1, 1)
avg(c(1,2,3))

sq <- function(n) {
  return(n*n)
}

df <- data.frame(
  Name = c("A", "B", "C"),
  Marks = c(65, 75, 85)
)
result <- apply(df["Marks"], 2, sq)
result

cube <- function(n) return(n*n*n)
cube(4)

eo <- function(n) {
  if(n%%2 == 0) return('even')
  return('odd')
}

eo(1)


min_max <- function(v) {
  print(min(v))
  print(max(v))
}

min_max(c(2,3,4,7,5,3,1))


bill <- function(n) {
  
}


fact <- function(n){
  if(n == 1) return(1)
  return(n * fact(n-1))
}

fact(2)