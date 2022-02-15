#' Automatically play a Wordle game
#' 
#' @param game_state The initial game state
#' @param guess_fun A guessing function (preferably cached), see
#'   \code{?wordle_choose_guess} or \code{?wordle_choose_guess_cache}
#' @param initial_guess The first word to guess
#' @param verbose_guess,verbose_state Be verbose for guessing or state
#'   generation?
#' @return The final game state
#' @export
wordle_autoplay <- function(game_state, guess_fun, initial_guess, verbose_guess=FALSE, verbose_state=FALSE) {
  game_state <- wordle_game_state(game_state, guess=initial_guess, verbose=verbose_state)
  while (game_state$history[length(game_state$history)] != 22222) {
    current_guess <- guess_fun(game_state=game_state, verbose=verbose_guess)
    game_state <- wordle_game_state(game_state, guess=names(current_guess)[1], verbose=verbose_state)
  }
  message(
    "Game complete for ", game_state$correct, "; ", length(game_state$history), " guesses; ",
    paste(names(game_state$history), game_state$history, sep="=", collapse=", ")
  )
  game_state
}
