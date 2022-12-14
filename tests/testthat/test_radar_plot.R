test_that("radar_plot function output check",{
  expect_no_error(
    radar_plot(spotify_appinfo(genres = "Funk",
                    features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
                    levels = c(9,8,5,4,7)))
  )
})
