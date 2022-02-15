#' @keywords internal
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end

#' wordle: A package for (automatically) playing wordle
#' 
#' @examples 
#' \dontrun{
#' # This takes a while, show a progress bar
#' pb_all_words <- txtProgressBar(min=0, max=nrow(wordle_colors), style=3)
#' # Setup your guessing cache
#' guess_cache_smallest_big_group <-
#'   wordle_choose_guess_cache(metric_fun=wordle_metric_smallest_big_group)
#' # Save your valuable output
#' ret <- list()
#' # Play all games
#' for (current_word in sort(wordle_colors$X)) {
#'   setTxtProgressBar(
#'     pb_all_words,
#'     value=getTxtProgressBar(pb_all_words) + 1, title="All words"
#'   )
#'   ret[[current_word]] <-
#'     wordle_autoplay(
#'       game_state=new_wordle_game(correct_word=current_word),
#'       guess_fun=wordle:::guess_cache_smallest_big_group,
#'       initial_guess="raise"
#'     )
#' }
#' }
NULL
