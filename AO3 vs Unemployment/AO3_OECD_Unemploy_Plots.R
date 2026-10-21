
library(ggplot2)

# Graph 1: AO3 log growth over time
ggplot(combined, aes(x = month, y = log_growth)) +
  geom_line(na.rm = TRUE) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(
    title = "Monthly AO3 Fanwork Growth",
    subtitle = "Log growth multiplied by 100",
    x = "Month",
    y = "Log growth (x100)"
  ) +
  theme_minimal()

# Graph 2: OECD unemployment rate over time
ggplot(combined, aes(x = month, y = unemployment_rate)) +
  geom_line(na.rm = TRUE) +
  labs(
    title = "Monthly OECD Unemployment Rate",
    x = "Month",
    y = "Unemployment rate (%)"
  ) +
  theme_minimal()

# Graph 3: Scatterplot
analysis_data <- subset(
  combined,
  !is.na(log_growth) &
    !is.na(unemployment_rate)
)

ggplot(
  analysis_data,
  aes(x = unemployment_rate, y = log_growth)
) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "AO3 Growth vs OECD Unemployment",
    subtitle = "Each point represents one month",
    x = "OECD unemployment rate (%)",
    y = "AO3 log growth (x100)"
  ) +
  theme_minimal()

# Simple Regression
model1 <- lm(
  log_growth ~ unemployment_rate,
  data = analysis_data
)

summary(model1)