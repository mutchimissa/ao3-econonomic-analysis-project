# ao3-econonomic-analysis-project
Seeing how growth rate of transformative works on Archive Of Our Own correlate with different macroeconomic indicators.

Currently: Gathering macroeconomic data from reliable sources to make data comparisons

## Research Question
Is the rate of transformative work creation on AO3 associated with global macroeconomic indicators between May 2007 to May 2025?

## Tools used (subject to change)
Python: Data extraction, cleaning, and processing
R: Preliminary data analysis and plotting of graphs
SQL: Data storage and joining

## Limitations & other things to keep in mind
Correlation does not equal causation. Results (and subsequent outliers) are subject heavily to outside influences.

There is a gap between April 2021 and April 2022 because of an error in data collection. An attempts to amend this was made by joining a second dataset to the first; anyhow, calculations will be made with this gap in mind.

## Data sources
2008-10 to 2021-02 -->  [Selective data dump for fan statisticians, AO3](https://archiveofourown.org/admin_posts/18804)

2021-03 to 2022-03 -->  Gap

2022-04 to 2025-02 -->  [archiveofourown-meta, trentmkelly](https://huggingface.co/datasets/trentmkelly/archiveofourown-meta)

## AO3 Log Growth Rate vs OECD Unemployment Rate (monthly)
### Correlation

- **Pearson correlation:** 0.09648145
- **Spearman correlation:** 0.02441151

### Simple Regression

**Model:** `log_growth ~ unemployment_rate`

#### Residuals

| Statistic | Value |
|---|---:|
| Min | -112.04 |
| 1st Quartile (1Q) | -10.45 |
| Median | -2.29 |
| 3rd Quartile (3Q) | 6.97 |
| Max | 342.78 |

#### Coefficients

| Variable | Estimate | Std. Error | t value | p-value |
|---|---:|---:|---:|---:|
| Intercept | -13.468 | 12.942 | -1.041 | 0.299 |
| Unemployment Rate | 2.452 | 1.885 | 1.301 | 0.195 |

#### Model Statistics

| Statistic | Value |
|---|---:|
| Residual Standard Error | 34.07 |
| Degrees of Freedom | 180 |
| Multiple R-squared | 0.009309 |
| Adjusted R-squared | 0.003805 |
| F-statistic | 1.691 |
| F-test p-value | 0.1951 |
| Observations | 182 |

## AO3 Log Growth Rate vs U.S. CPI (Monthly, 2017 onwards)
### Simple Regression: CPI Growth

**Model:** `log_growth ~ cpi_growth_pct`

#### Residuals

| Statistic | Value |
|---|---:|
| Min | -41.283 |
| 1st Quartile (1Q) | -5.668 |
| Median | 0.116 |
| 3rd Quartile (3Q) | 6.781 |
| Max | 37.134 |

#### Coefficients

| Variable | Estimate | Std. Error | t value | p-value |
|---|---:|---:|---:|---:|
| Intercept | 3.445 | 1.774 | 1.942 | 0.05558 |
| CPI Growth (%) | -12.433 | 4.701 | -2.645 | 0.00981 ** |

**Significance codes:** `***` p < 0.001, `**` p < 0.01, `*` p < 0.05, `.` p < 0.1

#### Model Statistics

| Statistic | Value |
|---|---:|
| Residual Standard Error | 13.26 |
| Degrees of Freedom | 81 |
| Multiple R-squared | 0.0795 |
| Adjusted R-squared | 0.06814 |
| F-statistic | 6.996 |
| F-test p-value | 0.009809 |
| Observations | 83 |

---

### Simple Regression: Lagged CPI Growth (1 Month)

**Model:** `log_growth ~ cpi_growth_lag1`

*Note: CPI growth is lagged by one month.*

#### Residuals

| Statistic | Value |
|---|---:|
| Min | -41.985 |
| 1st Quartile (1Q) | -7.683 |
| Median | -0.934 |
| 3rd Quartile (3Q) | 6.774 |
| Max | 40.934 |

#### Coefficients

| Variable | Estimate | Std. Error | t value | p-value |
|---|---:|---:|---:|---:|
| Intercept | 1.927 | 1.847 | 1.043 | 0.300 |
| Lagged CPI Growth | -5.045 | 4.903 | -1.029 | 0.307 |

#### Model Statistics

| Statistic | Value |
|---|---:|
| Residual Standard Error | 13.79 |
| Degrees of Freedom | 80 |
| Multiple R-squared | 0.01306 |
| Adjusted R-squared | 0.0007263 |
| F-statistic | 1.059 |
| F-test p-value | 0.3066 |
| Observations | 82 |
