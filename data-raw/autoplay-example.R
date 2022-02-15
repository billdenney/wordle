# Setup your guessing cache
guess_cache_smallest_big_group <-
  wordle_choose_guess_cache(metric_fun=wordle_metric_smallest_big_group)
# What is the best first guess?
initial_guess_smallest_big_group <-
  wordle_choose_guess(game_state=new_wordle_game(correct_word="pleat"), metric_fun=wordle_metric_smallest_big_group, verbose=TRUE)
initial_guess_smallest_big_group[initial_guess_smallest_big_group == min(initial_guess_smallest_big_group)]
# raise works well

pb_all_words <- txtProgressBar(min=0, max=nrow(wordle_colors), style=3)
# Save your valuable output
ret <- list()
# Play all games
for (current_word in sort(wordle_colors$X)) {
  setTxtProgressBar(
    pb_all_words,
    value=getTxtProgressBar(pb_all_words) + 1, title="All words"
  )
  ret[[current_word]] <-
    wordle_autoplay(
      game_state=new_wordle_game(correct_word=current_word),
      guess_fun=guess_cache_smallest_big_group,
      initial_guess="raise"#,
      #verbose_state=TRUE, verbose_guess=TRUE
    )
}

guess_distribution <- sapply(X=ret, FUN=function(x) length(x$history))
summary(guess_distribution)
ggplot2::ggplot(data=data.frame(distr=guess_distribution), aes(x=distr)) +
  geom_histogram()
