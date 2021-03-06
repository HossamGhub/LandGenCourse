chooseWEAddin <- function() {

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Choose Worked Example File"),
    miniUI::miniContentPanel(

      shiny::selectInput("type", "Choose a File Format:",
                  list("HTML in web browser (html)"=1,
                       "R markdown in RStudio (.Rmd)"=2,
                       "Plain R code in RStudio(.R)"=3),
                  selected = 1
      ),
      shiny::selectInput("example", "Choose a Worked Example:",
                   list("Week 1: Importing Genetic Data"=1,
                        "Week 2: Spatial Data"=2,
                        "Week 2: Bonus Material"=3,
                        "Week 3: Genetic Diversity"=4,
                        "Week 3: Bonus Material"=5,
                        "Week 4: Selection"=6,
                        "Week 4: Bonus Material"=7),
                  selected = 1
      )
    )
  )

  server <- function(input, output, session) {

    # Listen for 'done' events.
    shiny::observeEvent(input$done, {

      selectedFile <- paste0(c("Week1_vignette",
                               "Week2_vignette",
                               "Week2_bonus_vignette",
                               "Week3_vignette",
                               "Week3_bonus_vignette",
                               "Week4_vignette",
                               "Week4_bonus_vignette")[as.numeric(input$example)],
                             c(".html", ".Rmd", ".R")[as.numeric(input$type)])
      selectedPath <- (paste0(system.file("doc", selectedFile,
                       package = "LandGenCourse")))

      switch(input$type,
             "1" = utils::browseURL(paste0('file://', selectedPath)),
             "2" = rstudioapi::navigateToFile(selectedPath),
             "3" = rstudioapi::navigateToFile(selectedPath))

      cat(paste("Opening",selectedFile))
      shiny::stopApp()
    })

  }

  viewer <- shiny::dialogViewer("Choose Worked Example",
                                width = 400, height = 600)
  shiny::runGadget(ui, server, viewer = viewer)

}
