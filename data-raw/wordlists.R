# code to prepare `wordlists` dataset goes here
wordlists <- load_wordle_word_lists()

usethis::use_data(wordlists, overwrite = TRUE)
