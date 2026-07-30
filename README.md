# Long-Term S&P 500 Growth Modelling

## Overview

This project investigates long-term growth trends in the S&P 500 using historical market data and linear algebra techniques. The aim is to estimate how a hypothetical investment may grow over the next 20 years if recent historical trends continue.

Rather than using high-level regression functions, the model is built directly from the least-squares solution:

\[
\beta = (X^TX)^{-1}X^Ty
\]

This demonstrates the underlying mathematics behind linear regression and exponential growth modelling.

---

## Research Question

> How much could a $10,000 investment in an S&P 500 ETF be worth in 20 years if historical growth trends observed over the last two decades continue?

---

## Methodology

### 1. Data Collection

Historical S&P 500 adjusted closing prices are obtained from a publicly available dataset containing approximately one century of market data.

### 2. Data Cleaning

The dataset is:

- Filtered to retain dates and adjusted closing prices.
- Checked for missing values.
- Converted into a suitable format for analysis.

### 3. Log Transformation

Stock prices often exhibit approximately exponential growth over long periods.

To linearise the trend, prices are transformed using:

\[
y = \log(P)
\]

where:

- \(P\) = adjusted closing price
- \(y\) = transformed price

### 4. Least-Squares Fitting

A design matrix is constructed:

\[
X =
\begin{bmatrix}
1 & t_1 \\
1 & t_2 \\
\vdots & \vdots \\
1 & t_n
\end{bmatrix}
\]

The model parameters are estimated using:

\[
\beta = (X^TX)^{-1}X^Ty
\]

This provides the exponential growth trend that best fits the historical data.

### 5. Forecasting

The fitted model is projected forward by 20 years, producing an estimate of future index values under the assumption that the historical trend remains unchanged.

### 6. Investment Growth Projection

The future value of a hypothetical investment is calculated using:

\[
FV = PV \times \frac{P_{future}}{P_{current}}
\]

where:

- \(PV\) = present value
- \(FV\) = future value

---

## Technologies Used

- R
- dplyr
- Linear Algebra
- Least-Squares Regression
- Financial Data Analysis
- Data Visualisation

---

## Example Output

The project generates:

- Historical S&P 500 price plots
- Log-linear trend fits
- 20-year forecasts
- Estimated portfolio growth projections

Example visualisation:

- Historical Prices
- Fitted Exponential Trend
- Future Projection

---

## Key Findings

The model produces:

- Estimated long-term growth trend
- Future S&P 500 projection
- Projected value of a $10,000 investment
- Estimated profit over a 20-year horizon

The exact values depend on the most recent market data available when the analysis is performed.

---

## Limitations

This project is intended as an educational exercise rather than investment advice.

Several important limitations exist:

- Assumes historical growth continues unchanged.
- Ignores economic recessions and market crashes.
- Does not model changing interest rates.
- Does not account for valuation changes.
- Does not consider inflation.
- Does not include behavioural or macroeconomic factors.
- Uses a deterministic trend rather than a probabilistic forecasting model.

Because of these assumptions, results should be interpreted as trend-based estimates rather than realistic future predictions.

---

## Skills Demonstrated

This project demonstrates:

- Financial data analysis
- Linear algebra applications
- Least-squares modelling
- Time-series analysis
- Data cleaning and preprocessing
- Quantitative reasoning
- Scientific programming in R
- Research communication

---

## Future Improvements

Potential extensions include:

- CAGR analysis
- Volatility modelling
- Maximum drawdown calculations
- Monte Carlo simulations
- Comparison with exponential smoothing models
- Comparison with ARIMA forecasting techniques
- Risk-adjusted return metrics
- Dividend reinvestment modelling

---

## Limitations
- Assumes a constant growth rate.4
- Ignores recessions and economic shocks.5
-  Does not account for inflation.6
-  Uses a simple trend model rather than a financial forecasting model.
