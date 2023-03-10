#' @title radar plot for songs
#'
#' @description Draw a radar plot to show the value of one song (rank) of
#' each feature and also show the level of each feature that user choose.
#' @param x is an object of class spotify.
#' @param rank is the rank of the top 10 songs that we want to plot
#' @param ... other possible parameters for this method.
#' @return fig is the radar plot
#' @author Ting Yang
#' @import dplyr
#' @import plotly
#' @export
#' @examples
#' top10_song <- Spotify_scoring(genres = "Funk",
#' features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
#' levels = c(9,8,5,4,7))
#' radar_plot(top10_song, 1)
radar_plot <- function(x, rank, ...){

  # result list based on users' choices
  list_result <- x$result
  # calculate the mean value of every features' levels in the recommendation list
  result_level <- as.character()
  for (i in 1:5) {
    # as the first three columns are the tracks' basic info, so calculate the features' level from the third column
    l <- list_result[rank,i+3]
    result_level <- append(result_level,l)
  }

  # create initial plot
  fig <- plot_ly(
    type = 'scatterpolar',
    fill = 'toself')

  # add trace: plot for users' selections
  fig <- fig %>%
    add_trace(
      r = x$user_level,
      theta = x$user_feature,
      name = "User' selections")

  # add trace: plot for recommendation list based on users' selections
  fig <- fig %>%
    add_trace(
      r = result_level,
      theta = x$user_feature,
      name = 'Song')

  # format layout
  fig <- fig %>%
    layout(
      polar = list(radialaxis = list(visible = T,range = c(0,10),
                                     legend = list(font = list(family = "sans-serif",size = 15,color = "#000"),
                                                   bgcolor = "#E2E2E2",bordercolor = "#FFFFFF",borderwidth = 2))))

  return(fig)
}
