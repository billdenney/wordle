#' Generate a new Wordle game with a correct word
#' 
#' @param correct_word The word that is the correct word for the game
#' @param possible_df The data.frame of possible words
#' @param expected_char Number of characters expected for the correct_word
#' @return A "wordle_game" object which is a list with values of "correct",
#'   "possible_df", "available_rows" (the rows which have a chance of being
#'   correct as a logical vector), and "available_cols" (the columns which give
#'   non-degenerate information as a logical vector).
#' @export
new_wordle_game <- function(correct_word, possible_df=wordle_colors, expected_char=5) {
  stopifnot(is.character(correct_word))
  stopifnot(length(correct_word) == 1)
  stopifnot(nchar(correct_word) == expected_char)
  list(
    correct=correct_word,
    possible_df=possible_df,
    available_rows=rep(TRUE, nrow(possible_df)),
    available_cols=c(FALSE, rep(TRUE, ncol(possible_df) - 1))
  )
}

#' Update the game state with a new guess
#' 
#' @param game_state The game state either as returned by
#'   \code{new_wordle_game()} or this function.
#' @param guess The new word to guess
#' @param verbose Show progress information
#' @return An updated \code{game_state}
#' @export
wordle_game_state <- function(game_state, guess, verbose=TRUE) {
  guess_value <- game_state$possible_df[game_state$possible_df$X == game_state$correct, guess]
  history_new <- setNames(guess_value, guess)
  game_state$history <- c(game_state$history, history_new)
  game_state$available_rows <- game_state$available_rows & game_state$possible_df[, guess] == guess_value
  game_state$available_cols <- generate_available_cols(game_state, verbose=verbose)
  if (verbose) {
    message(
      "Number of possible words: ", sum(game_state$available_rows), "\n",
      "Number of possible guesses: ", sum(game_state$available_cols), "\n",
      "History: ", paste(names(game_state$history), game_state$history, sep="=", collapse=", ")
    )
  }
  game_state
}

#' Determine which columns make sense to guess
#' 
#' @param game_state The current game_state
#' @return A logical vector of logical columns to guess
generate_available_cols <- function(game_state, verbose=TRUE) {
  available_cols_original <- game_state$available_cols
  for (idx in which(game_state$available_cols)) {
    current_col_available_rows <- game_state$possible_df[[idx]][game_state$available_rows]
    if (all(current_col_available_rows == current_col_available_rows[1])) {
      game_state$available_cols[idx] <- FALSE
    }
  }
  if (verbose) {
    message("Columns removed: ", sum(available_cols_original) - sum(game_state$available_cols))
  }
  game_state$available_cols
}
