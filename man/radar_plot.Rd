% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/radar_plot.R
\name{radar_plot}
\alias{radar_plot}
\title{radar plot for songs}
\usage{
radar_plot(x, rank, ...)
}
\arguments{
\item{x}{is an object of class spotify.}

\item{rank}{is the rank of the top 10 songs that we want to plot}

\item{...}{other possible parameters for this method.}
}
\value{
fig is the radar plot
}
\description{
Draw a radar plot to show the value of one song (rank) of
each feature and also show the level of each feature that user choose.
}
\examples{
top10_song <- Spotify_scoring(genres = "Funk",
features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
levels = c(9,8,5,4,7))
radar_plot(top10_song, 1)
}
\author{
Ting Yang
}
