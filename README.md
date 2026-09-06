# 📈 Long-Term S&P 500 Growth Modelling

![R](https://img.shields.io/badge/R-Programming-blue)
![Finance](https://img.shields.io/badge/Finance-S%26P500-orange)
![Linear Algebra](https://img.shields.io/badge/Linear%20Algebra-Least%20Squares-green)
![Forecasting](https://img.shields.io/badge/Forecasting-20%20Years-red)

A quantitative finance project that uses historical S&P 500 data, linear algebra, and exponential trend modelling to investigate how a long-term investment may grow if recent market growth trends continue.

---

## 🎯 Research Question

> How might a $10,000 investment grow over the next 20 years if recent historical S&P 500 growth trends continue?

Using historical market data and a manually implemented least-squares regression model, this project estimates long-term growth trends and generates a 20-year market projection.

---

## 🔍 Key Findings

✅ Developed a forecasting model using the closed-form least-squares solution rather than high-level regression functions.

✅ Modelled exponential market growth through log transformation of historical S&P 500 prices.

✅ Generated a 20-year projection based on the long-term trend observed over the most recent 20 years of market data.

✅ Calculated projected future value and profit for a hypothetical $10,000 investment.

✅ Demonstrated practical applications of linear algebra in financial modelling and time-series analysis.

---

## 🛠 Technologies Used

- R
- dplyr
- Linear Algebra
- Least-Squares Regression
- Financial Time-Series Analysis
- Data Visualisation

---

## 📊 Dataset

Historical S&P 500 adjusted closing price data was obtained from a publicly available dataset containing approximately one century of market history.

Variables used:

- Date
- Adjusted Closing Price

The analysis focuses on the most recent 20 years of market performance to estimate current long-term growth behaviour.

---

## 🧮 Methodology

### 1. Data Collection

Historical S&P 500 adjusted closing prices were imported and cleaned using R.

### 2. Log Transformation

Because long-term asset growth is often approximately exponential, prices were transformed using:

```math
y = \log(P)
```

where:

- \(P\) = adjusted closing price
- \(y\) = transformed price

This converts exponential growth into a linear relationship.

### 3. Least-Squares Estimation

A design matrix was constructed:

```math
X =
\begin{bmatrix}
1 & t
\end{bmatrix}
```

Model parameters were then estimated using the closed-form least-squares solution:

```math
\hat{\beta}
=
(X^T X)^{-1} X^T y
```

Rather than relying on built-in regression functions, the model was built directly from the underlying mathematics.

### 4. Exponential Trend Reconstruction

Predicted log values were transformed back into price levels using:

```math
P = e^y
```

to produce the fitted market trend.

### 5. 20-Year Forecasting

The fitted exponential trend was projected forward by twenty years under the assumption that observed historical growth continues.

### 6. Investment Scenario

Future investment value was estimated using:

```math
FV = PV \times
\left(
\frac{P_{future}}
{P_{current}}
\right)
```

where:

- PV = Initial investment
- FV = Future value
- \(P_{future}\) = Projected future index value
- \(P_{current}\) = Current trend value

---

## 📈 Visualisation

### Historical Prices, Fitted Trend and Forecast

Rplot01.png

This figure shows:

- Historical S&P 500 prices
- Exponential trend fitted using least-squares estimation
- Twenty-year future projection

The fitted trend captures the underlying long-term growth trajectory while smoothing short-term market fluctuations.

---

## 💰 Example Projection

Using the fitted trend model, a hypothetical investment of:

```text
$10,000
```

was projected to grow to:

```text
$25,916.58
```

over a 20-year period.

Estimated profit:

```text
$15,916.58
```

This projection assumes that the growth trend observed in the most recent 20 years of S&P 500 data continues unchanged.

---

## 📊 Research Conclusions

The analysis suggests that:

### Long-Term Growth Remains Strong

Historical S&P 500 performance demonstrates a persistent upward trend over long investment horizons.

### Exponential Models Capture Long-Term Behaviour

Applying a logarithmic transformation allows long-term market growth to be modelled effectively using linear algebra techniques.

### Small Growth Differences Compound Significantly

Over long horizons, relatively small differences in annual growth can produce substantial differences in eventual portfolio value.

### Mathematical Models Can Inform Investment Planning

Simple trend-based forecasting provides useful insight into the effects of long-term compounding, even when future market behaviour is uncertain.

---

## ⚠️ Limitations

This project is intentionally simplified and should not be interpreted as an investment recommendation.

Limitations include:

- Assumes future growth resembles recent historical growth.
- Ignores market crashes and structural breaks.
- Does not model volatility.
- Does not incorporate macroeconomic variables.
- Does not account for interest rates or inflation.
- Does not include valuation metrics.
- Uses deterministic forecasting rather than probabilistic forecasting.

As a result, projections should be viewed as trend-based estimates rather than predictions.

---

## 🚀 Future Improvements

Potential extensions include:

- Monte Carlo simulation
- ARIMA forecasting
- Exponential smoothing models
- Volatility modelling
- Inflation-adjusted projections
- Dividend reinvestment analysis
- Maximum drawdown analysis
- Risk-adjusted performance metrics
