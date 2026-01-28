# R Basics - Getting Started

# This is a sample R script to help you get started with R programming

# 1. Variables and Data Types
# Numbers
x <- 10
y <- 3.14

# Strings
name <- "Big Data"

# Logical
is_student <- TRUE

# Print values
print(paste("x =", x))
print(paste("Name:", name))

# 2. Vectors
numbers <- c(1, 2, 3, 4, 5)
fruits <- c("apple", "banana", "orange")

print("Numbers vector:")
print(numbers)

# Vector operations
sum_numbers <- sum(numbers)
mean_numbers <- mean(numbers)
print(paste("Sum:", sum_numbers, "Mean:", mean_numbers))

# 3. Data Frames
# Create a simple data frame
df <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  age = c(25, 30, 35),
  score = c(85, 90, 88)
)

print("Data Frame:")
print(df)

# Access columns
print("Names:")
print(df$name)

# 4. Basic Statistics
data <- c(23, 45, 67, 89, 12, 34, 56, 78)
print(paste("Mean:", mean(data)))
print(paste("Median:", median(data)))
print(paste("Standard Deviation:", sd(data)))

# 5. Simple Plot (uncomment to run)
# plot(numbers, main="Simple Plot", xlab="Index", ylab="Value", type="l")
