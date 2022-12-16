#' @title Shiny application
#'
#' @description A shiny application as an example of using this package
#' @import shinydashboard
#' @import shiny
#' @import fresh
#' @import shinythemes
#' @import shinyWidgets
#' @import plotly
#' @import dplyr
#' @importFrom DT datatable JS
#' @importFrom magrittr %>%
#' @export
Spotify_gui = function(){
  appDir = system.file("SpotifyRcmd", package = "Spotify")
  shiny::runApp(appDir, display.mode = "normal")
}
