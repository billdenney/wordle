% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/game_setup.R
\name{wordle_has_letter_setup}
\alias{wordle_has_letter_setup}
\title{Generate a data.frame with all the letter/position for all words}
\usage{
wordle_has_letter_setup(word)
}
\arguments{
\item{word}{The vector of words (character vector)}
}
\value{
A data.frame with rownames of \code{word} and the first column "word"
containing \code{word}.  Then additional columns for each letter and
letter/position ("a", "a1", "a2", ...) with a boolean indicating if the
letter is in the word or the letter is in the word at the position.
}
\description{
Generate a data.frame with all the letter/position for all words
}
\examples{
wordle_has_letter_setup(c("binge", "splut"))
}
