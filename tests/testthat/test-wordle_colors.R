test_that("Color checking", {
  expect_equal(
    wordle_guess_colors_df(possible=c("awake", "evade"), all_words=c("aahed", "awake", "evade")),
    data.frame(
      X=    c("awake", "evade"),
      aahed=c( 21010,   10011),
      awake=c( 22222,   00202),
      evade=c( 00202,   22222),
      row.names=c("awake", "evade")
    )
  )
})
