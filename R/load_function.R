.onLoad <- function(...) {
  shiny::addResourcePath("www",
                         directoryPath = system.file("www", package = "Spotify") # path to resource in your package
  )
}
