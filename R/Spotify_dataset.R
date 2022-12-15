#' @title Spotify tracks dataset
#'
#' @description A \code{data.frame} that is for analyzing and visualizing.
#' It is a dataset of Spotify songs with different genres and their audio features.
#' The raw data is downloaded from Kaggle and cleaned before use.
#' @format A \code{data.frame} with 20 columns, which are:
#' \describe{
#' \item{Track_id}{The Spotify ID for the track}
#' \item{Artists}{The artists' names who performed the track. If there is more
#' than one artist, they are separated by a ;}
#' \item{Album_name}{The album name in which the track appears}
#' \item{Track_name}{Name of the track}
#' \item{Explicit}{Whether or not the track has explicit lyrics
#' (true = yes it does; false = no it does not OR unknown)}
#' \item{Key}{The key the track is in. Integers map to pitches using standard
#' Pitch Class notation. E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on.
#' If no key was detected, the value is -1}
#' \item{Mode}{Mode indicates the modality (major or minor) of a track,
#' the type of scale from which its melodic content is derived.
#' Major is represented by 1 and minor is 0}
#' \item{Time_signature}{An estimated time signature.
#' The time signature (meter) is a notational convention to specify
#' how many beats are in each bar (or measure). The time signature ranges from
#' 3 to 7 indicating time signatures of 3/4, to 7/4.}
#' \item{Track_genre}{The genre in which the track belongs}
#' \item{Popularity}{The popularity of a track is a value between 0 and 10,
#' with 10 being the most popular}
#' \item{Duration_ms}{This value describes the track length. It is between 0 and
#' 10, which is scaled from the track length in milliseconds}
#' \item{Danceability}{Danceability describes how suitable a track is for dancing.
#' A value of 0 is least danceable and 10 is most danceable}
#' \item{Energy}{A measure from 0 to 10 and represents a perceptual measure of
#' intensity and activity. Typically, energetic tracks feel fast, loud, and noisy.}
#' \item{Loudness}{The loudness of a track is a value between 0 and 10,
#' with 10 in largest decibels (dB)}
#' \item{Speechiness}{Speechiness detects the presence of spoken words in a track.
#' The value id from 0 to 1. The more exclusively speech-like the recording
#' (e.g. talk show, audio book, poetry), the closer to 10 the attribute value}
#' \item{Acousticness}{A confidence measure from 0 to 10 of whether the track is
#' acoustic. 10 represents high confidence the track is acoustic}
#' \item{Instrumentalness}{Predicts whether a track contains no vocals.
#' The closer the instrumentalness value is to 10, the greater likelihood the
#' track contains no vocal content}
#' \item{Liveness}{Detects the presence of an audience in the recording. The value
#' is from 0 to 10. Higher liveness values represent an increased probability
#' that the track was performed live.}
#' \item{Valence}{A measure from 0 to 10 describing the musical positiveness
#' conveyed by a track. Tracks with high valence sound more positive
#' (e.g. happy, cheerful, euphoric), while tracks with low valence sound more
#' negative (e.g. sad, depressed, angry)}
#' \item{Tempo}{A measurement of the speed or pace of a given piece. The value is
#' from 0 to 10. The higher value the speed is faster.}
#' }
#' @source <https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset?resource=download>
"Spotify_dataset"
