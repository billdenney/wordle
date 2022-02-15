#' Words for guessing and that may be correct in Wordle
#' 
#' @format A list with two named elements:
#' \describe{
#'   \item{possible}{Words that are possibly correct}
#'   \item{all}{Words that will not be correct, but can be guessed}
#' }
"wordlists"

#' "Colors" for Wordle guesses
#' 
#' @format A data.frame with rownames for the possible words (from
#'   \code{wordlists$possible}), the first column named "X" with the words
#'   repeated, and columns for each of the possible guesses. The values after
#'   the first column are integers indicating the colors of the word given the
#'   guess.  The colors are a 1 to 5-digit integer where 2 indicates that the
#'   letter matches in the current position, 1 indicates that the letter matches
#'   in a different position, and 0 indicates that the letter does not match.
"wordle_colors"
