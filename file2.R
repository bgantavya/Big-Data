a <- c(1, 2, 1)
print(class(a))
print(a)


char <- c('Hello', 'Buff')
print(char)

m1 = matrix(c(1: 9), nrow=3)
m1

v = c(1: 12)
w = c(9: 20)
m2 = cbind(v, w)
m3 = rbind(v, w)
m3


m4 = matrix(0, nrow=3, ncol=3)
m4

m5 = diag(1, 3)
m5

m6 = diag(c(2, 4, 6))
m6
rownames(m12) <- c("Row1", "Row2")
colnames(m12) <- c("Col1", "Col2", "Col3")

m12 <- matrix((1: 9), nrow=3)
m12

a = solve(m12)
a



l1 <- list(10, "R", TRUE)
l1

l2 <- list(number=10, name="R", passed=TRUE)
l2$name <- "Madhav"
l2$number <- NULL
l2

#
vec <- c(1, 2, 3)
mat <- matrix(1: 4, nrow=2)
df <- data.frame(id=1: 2, marks= c(80, 90))
l3 <-list(vec, mat, df)
l3$name

ns <- list(subject=list('English', 'Hindi'),
           name='R prog')
ns


length(ns)
str(ns)
names(ns)

list4 <- list()