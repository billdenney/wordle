#' Calculation metrics for Wordle
#' 
#' @param x A vector of possible colors (see \code{wordle_colors})
#' @return The metric calculated by the guessing method (lower values are
#'   better) as a named numeric vector where the names are the guess and the
#'   value is the metric value.
#' @name wordle_metric
NULL

#' @describeIn wordle_metric Choose the largest group size
#' @export
wordle_metric_smallest_big_group <- function(x) {
  max(summary(factor(x)))
}

#' @describeIn wordle_metric Choose the largest number to the median word
#' @export
wordle_metric_most_to_median_group <- function(x) {
  sf <- rev(sort(summary(factor(x))))
  -unname(which(cumsum(sf) > (length(x)/2))[1])
}

#' @describeIn wordle_metric Choose the smallest sized median group
#' @export
wordle_metric_smallest_median_group <- function(x) {
  sf <- sort(summary(factor(x)))
  unname(sf[which(cumsum(sf) > (length(x)/2))[1]])
}
