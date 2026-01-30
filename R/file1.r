a <- TRUE
b <- 'TRUE'
c <- charToRaw('TRUE')
d <- 1
e <- 3 + 2i
f <- 1L
print(class(a))
print(class(b))
print(class(c))
print(class(d))
print(class(e))
print(class(f))

apple <- c('red', 'green', 'yellow')
print(apple)
print(class(apple))

abc <- 123
appy <- c(abc, 'red','green')
print(appy)

print(5:13)
print(6.6: 12.6)
print(6.6: 12.3)

print(seq(5, 10, by = 0.125))
print(seq(1, 5, by = 0.12))

print(var)
print(var[1])

u <- var[c(1, 3)]
print(u)

print(v)
y <- 2
x <- 3
print(x+y)
print(seq(1,1000, by = 5))
print(seq(1,3, by = 0.5))

var <- c('apple', 'red', 5, TRUE)
v <- var[2:4]
v <- var[c(TRUE, FALSE)]

print(v)

print(var[c(-1, -3)])

v4 <- var[1]
v4