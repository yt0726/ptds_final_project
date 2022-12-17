test_that("Spotify_scoring function output check:
          the function returns 5 features that user chooses",{
  expect_length(
    Spotify_scoring(genres = "Funk",
                    features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
                    levels = c(9,8,5,4,7))$user_feature,5)
})
