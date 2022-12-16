#' @title Calculate the similarity of Spotify tracks
#'
#' @description Calculate the score of Spotify tracks according to the features
#' and the level for each feature that user choose.
#' @param genres A \code{string} contain the name of the genres that the user chooses.
#' @param features A \code{list} containing 5 characters. Each character represents
#' the feature that the user choose
#' @param levels A \code{list} containing 5 numerics. Each numeric represent the
#' value of each feature that user want.
#' @return list_values \code{list} containing the following attributes:
#' \describe{
#'      \item{result}{containing the top10 similarity tracks}
#'      \item{user_genre}{contain the genre that user choose}
#'      \item{user_feature}{contain the features that user choose}
#'      \item{user_level}{contain the level of each feature that user choose}
#'}
#' @author Ting Yang
#' @import dplyr
#' @import lsa
#' @export
#' @examples
#' spotify_similarity(genres = "Funk",
#' features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
#' levels = c(9,8,5,4,7))
spotify_similarity <- function(genres, features, levels){

  #user's selection
  genre <- genres
  level_1 <- levels[1]
  level_2 <- levels[2]
  level_3 <- levels[3]
  level_4 <- levels[4]
  level_5 <- levels[5]

  # As feature is char, it couldn't be added in mutate formula
  songs <- Spotify::Spotify_dataset %>%
    dplyr::select(.data$Artists, .data$Track_name, .data$Track_genre, features[1], features[2], features[3], features[4],
           features[5]) %>%
    filter(.data$Track_genre %in% genre)

  # Creation of the setup to compute the matrix of similarity score
  songs_transposed <- songs %>%
    dplyr::select(features[1], features[2], features[3], features[4], features[5])
  features_selected <- c(level_1, level_2, level_3, level_4, level_5)
  songs_transposed <- rbind(features_selected, songs_transposed)
  songs_transposed <- as.data.frame(t(songs_transposed)) %>%
    mutate_all(as.numeric)

  # Creation of the matrix: similarity score
  similarity_score <- cosine(as.matrix(songs_transposed))
  similarity_score_upper <- similarity_score
  similarity_score_upper[lower.tri(similarity_score_upper)] <- 0
  diag(similarity_score_upper) = 0
  # Get the top 10
  similarity_score_selected <- similarity_score_upper[1,]
  x <- which(similarity_score_selected >= sort(similarity_score_selected, decreasing = TRUE)[10],
             arr.ind = TRUE)
  x.order <- order(similarity_score_selected[x], decreasing = T)
  #select top 10, this is the result based on users' selection
  songs_top <- songs[x.order,]

  # create a list including result list, users' selection for further use
  spotify_appinfo_similarity <- list(
    result = songs_top,
    user_genre = genre,
    user_feature = features,
    user_level = levels
  )

  return(spotify_appinfo_similarity)
}
