# R Programming

This directory contains R programming exercises, scripts, and projects for Big Data analytics.

## 📋 Topics Covered

- Data structures (vectors, matrices, data frames, lists)
- Data manipulation with dplyr and tidyr
- Data visualization with ggplot2
- Statistical analysis
- Machine learning with R
- Big Data processing with R (sparklyr, RHadoop)

## 📁 Structure

```
R/
├── basics/           # Fundamental R programming concepts
├── data-analysis/    # Data analysis and manipulation
├── visualization/    # Data visualization exercises
├── statistics/       # Statistical analysis
├── machine-learning/ # ML algorithms and models
└── big-data/        # Big Data integration (Spark, Hadoop)
```

## 🔧 Setup

Install R and RStudio:
```bash
# On Ubuntu/Debian
sudo apt-get update
sudo apt-get install r-base r-base-dev

# Install common packages
R -e "install.packages(c('tidyverse', 'ggplot2', 'dplyr', 'tidyr'), repos='http://cran.rstudio.com/')"
```

## 📚 Resources

- [R for Data Science](https://r4ds.had.co.nz/)
- [CRAN Task View: High-Performance and Parallel Computing](https://cran.r-project.org/web/views/HighPerformanceComputing.html)
- [sparklyr - R interface for Apache Spark](https://spark.rstudio.com/)

## 💡 Example

```r
# Load libraries
library(dplyr)

# Read and analyze data
data <- read.csv("data.csv")
summary <- data %>%
  group_by(category) %>%
  summarise(mean_value = mean(value))
```
