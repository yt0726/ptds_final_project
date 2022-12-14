test_that("similarity function output check:the result contains top 10 songs",{
  expect_equal(nrow(
    spotify_similarity(genres = "Funk",
                       features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
                       levels = c(9,8,5,4,7))$result),10)
})
