# MA2511 - Applied Linear Algebra
# Project R Script Template
#
# Fill in the sections below with your own code.
# This script should reproduce the main results and figures in your report.

##########################################################
# 1. Project Information
##########################################################

# Student name: Khalid Elmasri
# Student ID: 52427759
# Project title: Analysis of Future of Stocks using Linear Algebra
#"How much is a S&P 500 ETF Investment Expected to grow in the next 20 years?"

##########################################################
# 2. Load Packages (if any)
##########################################################

# If you use extra packages, load them here.
# For example:
# library(ggplot2)
install.packages("dplyr")
library(dplyr)
##########################################################
# 3. Load Data 
##########################################################

# Option 1: Read from a CSV file
# data <- read.csv("your_data.csv")
data<- read.csv("https://raw.githubusercontent.com/fja05680/dow-sp500-100-years/refs/heads/master/SP500.csv") #S&P 500 last 100 years
# Option 2: Use a built-in dataset (for practice only)
# data <- mtcars

# Show the first few rows
# head(data)
head(data) #Shows the price from 30/12/1927-09/01/1928 of the SnP 500 ETF
##########################################################
# 4. Data Cleaning and Preprocessing
##########################################################

# Examples:
# - select columns of interest
# - remove missing values
# - create new variables

# data_clean <- subset(data, !is.na(variable_of_interest))
data_clean <- data%>% #selecting appropriate columns
  select(Date, Adj.Close) %>%
  mutate(Date = as.Date(Date)) %>%
  filter(!is.na(Date), !is.na(Adj.Close))

##########################################################
# 5. Exploratory Plots
##########################################################

# Example scatter plot:
# plot(data_clean$x, data_clean$y,
#      xlab = "X variable", ylab = "Y variable",
#      main = "Scatter plot of Y vs X")
colnames(data) #graph of S&P 500 last 100 years
plot(data_clean$Date, data_clean$Adj.Close,
     type="l" ,
     col="red",
     xlab="Date",
     ylab="Adj.close",
     main="S&P 500  (1928-2019)")
##########################################################
# 6. Linear Algebra Methods
##########################################################

# Example: Construct design matrix for linear regression
# A <- cbind(1, data_clean$x)   # column of ones + predictor
# b <- data_clean$y

# Least-squares solution via normal equations:
# x_hat <- solve(t(A) %*% A, t(A) %*% b)
# x_hat

# Example: PCA
# X <- as.matrix(data_clean[, c("var1", "var2", "var3")])
# pca_res <- prcomp(X, center = TRUE, scale. = FALSE)
# summary(pca_res)
# pca_res$rotation
# pca_res$x
years<-20
no_days<-252*years #number of trading days multiplied by 20 years
data_20years<-tail(data_clean,no_days)

p<-data_20years$Adj.Close #price vector
p_log <- log(data_20years$Adj.Close) #price vector treated as exponential

T <- length(p_log) # Time index
t <- 0:(T - 1)

X <- cbind(1, t) #Design matrix

beta_hat <- solve(t(X) %*% X) %*% t(X) %*% p_log # Least squares

trend_log <- X %*% beta_hat # compound trend
trend <- as.numeric(exp(trend_log))

#profit in the future
future_years <- 20

future_dates <- seq(
  from = max(data_20years$Date),
  by   = "year",
  length.out = future_years + 1
)
t_future <- T + (0:future_years) * 252
X_future <- cbind(1, t_future)

p_future_log <- X_future %*% beta_hat
p_future <- as.numeric(exp(p_future_log))

##########################################################
# 7. Visualisation of Results
##########################################################

# Example: fitted line vs data
# plot(data_clean$x, data_clean$y,
#      xlab = "X", ylab = "Y", main = "Data with fitted line")
# abline(a = x_hat[1], b = x_hat[2])

# Example: PCA scores plot
# scores <- pca_res$x
# plot(scores[,1], scores[,2],
#      xlab = "PC1", ylab = "PC2",
#      main = "PCA scores")
# abline(h = 0, v = 0, col = "grey")

y_range <- range(c(data_20years$Adj.Close, trend, p_future), na.rm = TRUE) 
padding <- 0.15 * diff(y_range)

plot(
  data_20years$Date,
  data_20years$Adj.Close,
  type = "l",
  col = "red",
  lwd = 1,
  xlim = range(c(data_20years$Date, future_dates)),
  xlab = "Date",
  ylim = c(y_range[1] - padding, y_range[2] + padding),
  ylab = "Adjusted Close",
  main = "S&P 500: Compound Growth Trend and 20-Year Projection"
)

lines(data_20years$Date, trend, col = "blue", lwd = 3)
lines(future_dates, p_future, col = "green", lwd = 3, lty = 2)
abline(v = max(data_20years$Date), col = "red", lty = 3)

legend(
  "topleft",
  legend = c("Observed Prices", "Compound Trend", "Future Projection"),
  col = c("red", "blue", "green"),
  lwd = c(1, 3, 3),
  lty = c(1, 1, 2)
)

investment <- 10000
P0 <- tail(trend, 1)
P_future <- tail(p_future, 1)

future_value <- investment * (P_future / P0)
profit <- future_value - investment

future_value
profit

##########################################################
# 8. Save Figures (Optional)
##########################################################
# Example:
# pdf("my_figure.pdf")
# plot(data_clean$x, data_clean$y)
# dev.off()

##########################################################
# 9. Session Information (Optional)
##########################################################

# sessionInfo()
