#' @title Calculate the score of Spotify tracks
#'
#' @description Calculate the score of Spotify tracks according to the features
#' and the level for each feature that user choose.
#' @param genres A \code{string} contain the name of the genres that the user chooses.
#' @param feature A \code{list} containing 5 characters. Each character represents
#' the feature that the user choose
#' @param levels A \code{list} containing 5 numerics. Each numeric represent the
#' value of each feature that user want.
#' @return list_values \code{list} containing the following attributes:
#' \describe{
#'      \item{result}{containing the top10 scores tracks}
#'      \item{user_genre}{contain the genre that user choose}
#'      \item{user_feature}{contain the features that user choose}
#'      \item{user_level}{contain the level of each feature that user choose}
#'}
#' @author Ting Yang
#' @import dplyr
#' @export
#' @examples
#' spotify_appinfo(genres = "Funk",
#' features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
#' levels = c(9,8,5,4,7))
spotify_appinfo <- function(genres,features,levels){

  #user's selection
  genre<- genres
  level_1 <- levels[1]
  level_2 <- levels[2]
  level_3 <- levels[3]
  level_4 <- levels[4]
  level_5 <- levels[5]

  # as feature is char, it couldn't be added in mutate formula
  Songs <- Spotify %>%
    select(Artists,Track_name,Track_genre,
           features[1],features[2],features[3],features[4],features[5])%>%
    filter(Spotify$Track_genre %in% genre)

  # calculate the score
  Songs <- Songs %>%
    mutate(`score_1` = 10-(abs(level_1-Songs[,4])),
           `score_2`= 10-(abs(level_2-Songs[,5])),
           `score_3`= 10-(abs(level_3-Songs[,6])),
           `score_4`=10-(abs(level_4-Songs[,7])),
           `score_5`= 10-(abs(level_5-Songs[,8]))) %>%
    mutate(final_score=(0.5*`score_1`+0.2*`score_2`+0.15*`score_3`+0.01*`score_4`+0.05*`score_5`)/5)
  top <- Songs[order(-Songs$final_score),]
  #select top 10, this is the result based on users' selection
  top10 <- top[1:10,]

  # create a list including result list, users' selection for further use
  spotify_appinfo <- list(
    result = top10,
    user_genre = genre,
    user_feature = features,
    user_level = levels

  )
  class(spotify_appinfo) = "spotify"
  return(spotify_appinfo)
}



#' @title radar plot for songs
#'
#' @description Draw a radar plot to show the average value of top 10 songs of
#' each feature and also show the level of each feature that user choose.
#' @param x is an object of class spotify.
#' @return fig is the radar plot
#' @author Ting Yang
#' @import dplyr
#' @import plotly
#' @export
#' @examples
#' top10_song <- spotify_appinfo(genres = "Funk",
#' features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
#' levels = c(9,8,5,4,7))
#' plot(top10_song)
plot.spotify <- function(x,...){

  # result list based on users' choices
  list_result <- x$result
  # calculate the mean value of every features' levels in the recommendation list
  result_level <- as.character()
  for (i in 1:5) {
    # as the first three columns are the tracks' basic info, so calculate the features' level from the third column
    l <- list_result[,i+3]
    l <- mean(l)
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
      name = "Users' selections")

  # add trace: plot for recommendation list based on users' selections
  fig <- fig %>%
    add_trace(
      r = result_level,
      theta = x$user_feature,
      name = 'Result list')

  # format layout
  fig <- fig %>%
    layout(
      polar = list(radialaxis = list(visible = T,range = c(0,10),
                                     legend = list(font = list(family = "sans-serif",size = 15,color = "#000"),
                                                   bgcolor = "#E2E2E2",bordercolor = "#FFFFFF",borderwidth = 2))))

  return(fig)
}
