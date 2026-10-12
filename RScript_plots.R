#convert date
ao3$month <- as.Date(
  paste0(substr(ao3$month, 1, 7), "-01")
)

#log growth
ao3$log_growth <- NA_real_

for (i in 2:nrow(ao3)) {
  
  current_works <- ao3$new_works[i]
  previous_works <- ao3$new_works[i - 1]
  
  if (
    !is.na(current_works) &&
    !is.na(previous_works) &&
    current_works > 0 &&
    previous_works > 0
  ) {
    ao3$log_growth[i] <-
      100 * (log(current_works) - log(previous_works))
  }
}

#percentage growth plot
plot(
  ao3$month,
  ao3$growth_rate_pct,
  type = "l",
  xlab = "Month",
  ylab = "Growth rate (%)",
  main = "Monthly AO3 Ordinary Percentage Growth"
)

abline(h = 0, lty = 2)

#log growth plot
plot(
  ao3$month,
  ao3$log_growth,
  type = "l",
  xlab = "Month",
  ylab = "Log growth (x100)",
  main = "Monthly AO3 Log Growth"
)

abline(h = 0, lty = 2)

par(mfrow = c(1, 2))

# Histogram 1: Ordinary percentage growth
hist(
  ao3$growth_rate_pct,
  breaks = 30,
  main = "Ordinary Growth",
  xlab = "Growth rate (%)",
  col = "lightblue",
  border = "white"
)

# Histogram 2: Log growth
hist(
  ao3$log_growth,
  breaks = 30,
  main = "Log Growth",
  xlab = "Log growth (x100)",
  col = "lightgreen",
  border = "white"
)

par(mfrow = c(1, 1))

#November 2009 outlier , dummy variable
beta_opening_month <- as.Date("2009-11-01")

ao3$beta_opening <- ifelse(
  ao3$month == beta_opening_month,
  1,
  0
)
ao3[
  ao3$beta_opening == 1,
  c("month", "new_works", "log_growth", "beta_opening")
]
