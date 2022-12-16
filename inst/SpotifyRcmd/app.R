# backgroud photo link
# bg_url <- "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG11c2ljfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60"
### SHINY UI ###
ui <- fluidPage(

  navbarPage(theme = shinythemes::shinytheme("yeti"), collapsible = TRUE,
             HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">PTDS_Spotify</a>'),
             id="nav", windowTitle = "PTDS_Spotify",
             # shinyWidgets::setBackgroundImage(src= bg_url), # give a backgroud photo
             #first page
             tabPanel("Introduction",
                      fluidRow(
                        h1("Welcome to our application"),
                        p("We are pleased that you are using our application. Our objective is to give you a list of recommended songs based on your tastes."),
                        p("The motivation behind this application is that we all want to discover new songs, but sometimes, it can be tricky to get the ones that fit our tastes."),
                        p("Based on our own algorithm, we allow you to choose between different features:")
                      )
             ),
             #second page
             tabPanel("Recommendation",
                      # a series of custom keys
                      fluidRow(align = "center",
                               column(12,
                                      shiny::selectInput("scoring_method", "", choices = c("Similarity", "Score")))
                      ),
                      fluidRow(align = "center",
                               p(""),
                               p("To use our algorithm, choose first your genre, then the features in the order of importance, and click the button to get the recommended songs.")
                      ),
                      fluidRow(align = "center",
                               column(12,
                                      shiny::selectInput("genre", "", choices =  sort(unique(Spotify_dataset$Track_genre)),selected = NULL,multiple = T))
                      ),
                      fluidRow(
                        column(2, offset = 1,
                               shiny::selectizeInput("feature_1", "Select the first feature",choices =  colnames(Spotify_dataset)[10:20],  multiple = F),
                               shiny::sliderInput("lev1", NULL, min = 0, max = 10, value = 0,ticks=F)),
                        column(2,
                               shiny::selectizeInput("feature_2", "Second feature", choices =  colnames(Spotify_dataset)[10:20],  multiple = F),
                               shiny::sliderInput("lev2", NULL, min = 0, max = 10, value = 0,ticks=F)),
                        column(2,
                               shiny::selectizeInput("feature_3", "Third feature",choices =  colnames(Spotify_dataset)[10:20], multiple = F),
                               shiny::sliderInput("lev3", NULL, min = 0, max = 10, value = 0,ticks=F)),
                        column(2,
                               shiny::selectizeInput("feature_4", "Fourth feature", choices =  colnames(Spotify_dataset)[10:20], multiple = F),
                               shiny::sliderInput("lev4", NULL, min = 0, max = 10, value = 0,ticks=F)),
                        column(2,
                               shiny::selectizeInput("feature_5", "Fifth feature",choices =  colnames(Spotify_dataset)[10:20], multiple = F),
                               shiny::sliderInput("lev5", NULL, min = 0, max = 10, value = 0,ticks=F))
                      ),
                      fluidRow(
                        column(12, align = "center",
                               shiny::actionButton("launch", "Get the recommended songs", icon("music")))
                      ),
                      fluidRow(
                        DT::DTOutput("result")
                      ),
                      fluidRow(
                        column(4,
                               plotly::plotlyOutput("radar_plot1", height = 500)),
                        column(4,
                               plotly::plotlyOutput("radar_plot2", height = 500)),
                        column(4,
                               plotly::plotlyOutput("radar_plot3", height = 500)),
                      )
             )
  )
)

### SHINY SERVER ###
server = function(input, output, session) {
  ## reactive informations -----
  # capture users' preference
  features <- reactive(c(input$feature_1,input$feature_2,input$feature_3,input$feature_4,input$feature_5))
  level <- reactive(c(input$lev1,input$lev2,input$lev3,input$lev4,input$lev5))
  genre <- reactive(input$genre)

  # only when users select un-repeating features and at least one level, the scoring function can be activated
  # basic_info will return the recommendation result list calculated by users' selection, and users' selections as well
  # basic info covers all info that might be used in the following step
  basic_info <- eventReactive(input$launch, {
    if (any(duplicated(features()))!=T && sum(level())>0) {
      if (input$scoring_method == "Score") {
        basic_info <- spotify_appinfo(genres = genre(),levels = level(),feature = features())
      } else if (input$scoring_method == "Similarity") {
        basic_info <- spotify_similarity(genres = genre(),levels = level(),feature = features())
      }
    }
  })

  ## output -----
  ### second page ----

  # render the first table, result base on users' preference
  output$result <- DT::renderDT({
    if (any(duplicated(features()))!=T && sum(level())>0) {
      # only return the result list，Artists,Track_name,Track_genre column
      list_result <- basic_info()
      list_result <- list_result$result
      # if user complete selection, it will begin to return corresponding results
      list_result <- dplyr::select(list_result,Artists,Track_name,Track_genre)

      DT::datatable(list_result, extensions = 'Buttons',
                    rownames = FALSE,
                    options = list(paging=FALSE, processing=FALSE,
                                   dom = 'Bfrtip',buttons = c('copy', 'csv', 'excel', 'pdf', 'print'),
                                   initComplete = DT::JS(
                                     "function(settings, json) {",
                                     "$(this.api().table().header()).css({'background-color': '#2E3440	', 'color': '#FFFFFF'});",
                                     "$(this.api().table().body()).css({'background-color': '#2E3440	', 'color': '#FFFFFF'});",
                                     "}") #replace bg color of table
                    ))
    }
  })
  ### third page ----

  # render the preference the users chose above, can be compared with the radar plot
  output$genre_preference <- renderText({genre()})

  output$user_preference <- renderTable({
    data.frame("Features" = features(),
               "Levels" = level())})

  # radar plot for the first song
  output$radar_plot1 <- plotly::renderPlotly({
    radar_plot(basic_info(), 1)
  })

  # radar plot for the second song
  output$radar_plot2 <- plotly::renderPlotly({
    radar_plot(basic_info(), 2)
  })

  # radar plot for the third song
  output$radar_plot3 <- plotly::renderPlotly({
    radar_plot(basic_info(), 3)
  })

}
shinyApp(ui, server)
