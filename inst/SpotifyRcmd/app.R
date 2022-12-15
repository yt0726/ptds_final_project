# backgroud photo link
bg_url <- "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fG11c2ljfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60"
### SHINY UI ###
ui <- bootstrapPage(

  navbarPage(theme = shinythemes::shinytheme("flatly"), collapsible = TRUE,
             HTML('<a style="text-decoration:none;cursor:default;color:#FFFFFF;" class="active" href="#">PTDS_Spotify</a>'),
             id="nav", windowTitle = "PTDS_Spotify",
             shinyWidgets::setBackgroundImage(src= bg_url), # give a backgroud photo
             #first page
             tabPanel("Introduction"),
             #second page
             tabPanel("Custom",
                      # a series of custom keys
                      sidebarLayout(
                        sidebarPanel(width = 4,
                                     span(tags$i(h5("Choose the music genre,",br(),"then five un-repeating features you care",
                                                    br(), "and their corresponding levels")),
                                          style="color:#045a8d"),
                                     shinyWidgets::pickerInput("genre","Select or search for one or multiple genres",
                                                 choices =  unique(Spotify_dataset$Track_genre),selected = NULL,multiple = T),
                                     shiny::selectizeInput("feature_1", "Feature 1",choices =  colnames(Spotify_dataset)[10:20],  multiple = F),
                                     shiny::sliderInput("lev1", NULL, min = 0, max = 10, value = 0,ticks=F),
                                     shiny::selectizeInput("feature_2", "Feature 2", choices =  colnames(Spotify_dataset)[10:20],  multiple = F),
                                     shiny::sliderInput("lev2", NULL, min = 0, max = 10, value = 0,ticks=F),
                                     shiny::selectizeInput("feature_3", "Feature 3",choices =  colnames(Spotify_dataset)[10:20], multiple = F),
                                     shiny::sliderInput("lev3", NULL, min = 0, max = 10, value = 0,ticks=F),
                                     shiny::selectizeInput("feature_4", "Feature 4",choices =  colnames(Spotify_dataset)[10:20], multiple = F),
                                     shiny::sliderInput("lev4", NULL, min = 0, max = 10, value = 0,ticks=F),
                                     shiny::selectizeInput("feature_5", "Feature 5",choices =  colnames(Spotify_dataset)[10:20], multiple = F),
                                     shiny::sliderInput("lev5", NULL, min = 0, max = 10, value = 0,ticks=F)
                        ),
                        mainPanel(
                          DT::DTOutput("result"),
                          width = 8
                        )
                      )

             ),
             #third page
             tabPanel("Result Radar",
                      div(class="outer",
                          tags$head(href="style.css"),
                          absolutePanel(id = "controls", class = "panel panel-default",
                                        top = 100, left = 80, width = 400, fixed=TRUE,
                                        draggable = TRUE, height = "auto",
                                        span(tags$i(h3("Your preference chosen before")), style="color:#045a8d"),
                                        span(tags$i(h5("You chose genres of music: ")), style="color:#000000"),
                                        textOutput("genre_preference"),
                                        br(),
                                        tableOutput("user_preference")
                          ),

                          absolutePanel(id = "mainpage", class = "panel panel-default",
                                        top = 100, left = 500, width = 800, fixed=TRUE, height = 550,
                                        br(),
                                        plotly::plotlyOutput("radar_plot", height = 500)
                          )
                      )
             ),
             tabPanel("More Recommendation")
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
  basic_info <- reactive({
    if (any(duplicated(features()))!=T && sum(level())>0) {
      basic_info <- spotify_appinfo(genres = genre(),levels = level(),feature = features())
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

  # radar plot
  output$radar_plot <- plotly::renderPlotly({
    radar_plot(basic_info())
  })

}
shinyApp(ui, server)
