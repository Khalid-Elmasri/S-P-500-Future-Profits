
##########################################################
# 1. Project Information
##########################################################

# Student name: Khalid Elmasri
# Project title: Analysis of Future of Stocks using Linear Algebra
#"How much is a S&P 500 ETF Investment Expected to grow in the next 20 years?"

##########################################################
# 2. Load Packages 
##########################################################

install.packages("dplyr")
library(dplyr)

##########################################################
# 3. Load Data 
##########################################################

data<- read.csv("https://raw.githubusercontent.com/fja05680/dow-sp500-100-years/refs/heads/master/SP500.csv") #S&P 500 last 100 years

# Showing the first few rows
head(data) #Shows the price from 30/12/1927-09/01/1928 of the SnP 500 ETF
##########################################################
# 4. Data Cleaning and Preprocessing
##########################################################

data_clean <- data%>% #selecting appropriate columns
  select(Date, Adj.Close) %>%
  mutate(Date = as.Date(Date)) %>%
  filter(!is.na(Date), !is.na(Adj.Close))

##########################################################
# 5. Exploratory Plots
##########################################################

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
