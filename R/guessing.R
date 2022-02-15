#' Choose a guess based on a game_state and a metric function
#' 
#' @param game_state The output of \code{new_wordle_game()} or \code{wordle_game_state()}
#' @param metric_fun The metric function to use for guessing; the guess with the
#'   lowest metric value will be used, and being in the possible words will be
#'   used if more than one has an equal metric value.
#' @param verbose Show more information
#' @return The guess
#' @family Wordle guessing
#' @export
wordle_choose_guess <- function(game_state, metric_fun, verbose=TRUE) {
  possible_words <- game_state$possible_df[[1]][game_state$available_rows]
  if (length(possible_words) < 3) {
    # If there are two choices, guess
    return(setNames(rep(-Inf, length(possible_words)), possible_words))
  }
  if (!is.list(metric_fun)) {
    metric_fun <- list(metric_fun)
  }
  if (verbose) {
    pb <- txtProgressBar(min=0, max=sum(game_state$available_cols), style=3)
    pb_metric_fun <- function(...) {
      setTxtProgressBar(pb, value=getTxtProgressBar(pb) + 1)
      metric_fun[[1]](...)
    }
  } else {
    pb_metric_fun <- metric_fun[[1]]
  }
  metrics <-
    sapply(
      # operate only on the available rows from the available columns
      X=game_state$possible_df[game_state$available_cols][game_state$available_rows, ],
      FUN=pb_metric_fun
    )
  # First prioritize improved metrics.  Then prioritize words that are possible
  # (so that you can get it in 1 more).
  ret_metrics <- metrics[order(metrics, -(names(metrics) %in% possible_words))]
  # If there are more than one metric functions defined, break top-level ties with the next metric function
  mask_equal_to_best <- ret_metrics == ret_metrics[[1]]
  if ((length(metric_fun) > 1) & sum(mask_equal_to_best) > 1) {
    metrics2 <-
      sapply(
        # operate only on the available rows from the available columns
        X=game_state$possible_df[names(ret_metrics)][game_state$available_rows, ],
        FUN=metric_fun[[2]]
      )
    ret <- ret_metrics[mask_equal_to_best][order(metrics2)]
  } else {
    ret <- ret_metrics
  }
  ret
}

#' Generate a guessing cache function
#' 
#' @param metric_fun The function to use for calculation of the metric (see
#'   \code{?wordle_metric})
#' @return A function with a cache
#' @family Wordle guessing
#' @export
wordle_choose_guess_cache <- function(metric_fun) {
  cache <- force(list())
  metric_fun <- force(metric_fun)
  function(game_state, verbose) {
    if (is.null(game_state$history)) {
      # Set to an impossible guess if there is no history
      history_chr <- "X_"
    } else {
      history_chr <- paste(names(game_state$history), game_state$history, sep="=", collapse=", ")
    }
    if (history_chr %in% names(cache)) {
      if (verbose) message("Using cache for ", history_chr, ": ", names(cache[[history_chr]]))
    } else {
      # Only store the first guess, since that is all that is used.
      cache[[history_chr]] <<- wordle_choose_guess(game_state=game_state, metric_fun=metric_fun, verbose=verbose)[1]
    }
    cache[[history_chr]]
  }
}

# guess_cache_smallest_big_group <- wordle_choose_guess_cache(metric_fun=wordle_metric_smallest_big_group)
# guess_cache_smallest_median_group <- wordle_choose_guess_cache(metric_fun=wordle_metric_smallest_median_group)
# guess_cache_smallest_big_then_median_group <- wordle_choose_guess_cache(metric_fun=list(wordle_metric_smallest_big_group, wordle_metric_smallest_median_group))
