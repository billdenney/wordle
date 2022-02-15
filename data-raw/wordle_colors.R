## code to prepare `wordle_colors` dataset goes here
wordle_colors <- wordle_guess_colors_df(possible=wordlists$possible, all_words=wordlists$all)

usethis::use_data(wordle_colors, overwrite = TRUE)
