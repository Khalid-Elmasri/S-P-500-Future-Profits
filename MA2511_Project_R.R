
# ==========================================
# Long-Term S&P 500 Growth Modelling
# ==========================================
#
# Research Question:
# How might a $10,000 investment grow over
# the next 20 years if recent historical
# S&P 500 growth trends continue?
#
# Method:
# - Historical S&P 500 data
# - Log transformation
# - Least-squares estimation using
#   linear algebra
# - Exponential trend forecasting
#
# ==========================================

library(dplyr)

# ==========================================
# Data Loading
# ==========================================

load_data <- function(url) {

  data <- read.csv(url)

  data %>%
    select(Date, Adj.Close) %>%
    mutate(Date = as.Date(Date)) %>%
    filter(!is.na(Date), !is.na(Adj.Close))
}

# ==========================================
# Model Fitting
# ==========================================

fit_log_linear_model <- function(prices) {

  log_prices <- log(prices)

  T <- length(log_prices)
  t <- 0:(T - 1)

  X <- cbind(1, t)

  beta_hat <- solve(t(X) %*% X) %*%
    t(X) %*%
    log_prices

  list(
    beta = beta_hat,
    T = T,
    X = X,
    trend_log = X %*% beta_hat
  )
}

# ==========================================
# Forecasting
# ==========================================

forecast_prices <- function(beta_hat,
                            T,
                            years_ahead = 20) {

  trading_days <- 252

  future_dates <- seq(
    from = max(data_recent$Date),
    by = "year",
    length.out = years_ahead + 1
  )

  t_future <- T + (0:years_ahead) * trading_days

  X_future <- cbind(1, t_future)

  future_log <- X_future %*% beta_hat

  list(
    dates = future_dates,
    prices = as.numeric(exp(future_log))
  )
}

# ==========================================
# Investment Metrics
# ==========================================

calculate_investment_growth <- function(
  initial_investment,
  current_trend_value,
  future_trend_value
) {

  future_value <- initial_investment *
    (future_trend_value / current_trend_value)

  profit <- future_value - initial_investment

  list(
    future_value = future_value,
    profit = profit
  )
}

# ==========================================
# Data Source
# ==========================================

data_url <- "https://raw.githubusercontent.com/fja05680/dow-sp500-100-years/refs/heads/master/SP500.csv"

sp500 <- load_data(data_url)

# ==========================================
# Select Last 20 Years
# ==========================================

years_used <- 20
trading_days <- 252

recent_days <- years_used * trading_days

data_recent <- tail(sp500, recent_days)

# ==========================================
# Fit Model
# ==========================================

model <- fit_log_linear_model(
  data_recent$Adj.Close
)

trend_prices <- exp(model$trend_log)

# ==========================================
# Generate Forecast
# ==========================================

forecast <- forecast_prices(
  beta_hat = model$beta,
  T = model$T,
  years_ahead = 20
)

# ==========================================
# Plot Results
# ==========================================

y_range <- range(
  c(
    data_recent$Adj.Close,
    trend_prices,
    forecast$prices
  )
)

padding <- 0.15 * diff(y_range)

plot(
  data_recent$Date,
  data_recent$Adj.Close,
  type = "l",
  col = "red",
  lwd = 1,
  xlim = range(
    c(
      data_recent$Date,
      forecast$dates
    )
  ),
  ylim = c(
    y_range[1] - padding,
    y_range[2] + padding
  ),
  xlab = "Date",
  ylab = "Adjusted Close",
  main = "S&P 500 Long-Term Trend Projection"
)

lines(
  data_recent$Date,
  trend_prices,
  col = "blue",
  lwd = 3
)

lines(
  forecast$dates,
  forecast$prices,
  col = "darkgreen",
  lwd = 3,
  lty = 2
)

abline(
  v = max(data_recent$Date),
  col = "black",
  lty = 3
)

legend(
  "topleft",
  legend = c(
    "Observed Prices",
    "Fitted Trend",
    "Forecast"
  ),
  col = c(
    "red",
    "blue",
    "darkgreen"
  ),
  lwd = c(
    1,
    3,
    3
  ),
  lty = c(
    1,
    1,
    2
  )
)

# ==========================================
# Investment Scenario
# ==========================================

investment <- 10000

current_trend <- tail(trend_prices, 1)

future_trend <- tail(
  forecast$prices,
  1
)

results <- calculate_investment_growth(
  investment,
  current_trend,
  future_trend
)

cat("\n")
cat("===================================\n")
cat("Investment Projection\n")
cat("===================================\n")
cat("Initial Investment: $", investment, "\n")
cat("Projected Value:    $", round(results$future_value, 2), "\n")
cat("Projected Profit:   $", round(results$profit, 2), "\n")
cat("===================================\n")
