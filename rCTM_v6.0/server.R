#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Define server logic
shinyServer(function(input, output, session) {
  
  #Make a reactive function to populate inputParms
  getParms <- reactive({
    
    
    inputParms <- list(startYear = input$dateRange[1],
                       endYear = input$dateRange[2],
                       relSeaLevelRiseInit = input$relSeaLevelRiseInit,
                       relSeaLevelRiseTotal = input$relSeaLevelRiseTotal,
                       initElv = input$initElev,
                       meanSeaLevel = input$meanSeaLevel,
                       meanSeaLevelDatum = input$meanSeaLevelDatum,
                       meanHighWater = input$meanHighWater,
                       meanHighHighWater = input$meanHighHighWater,
                       meanHighHighWaterSpring = input$meanHighHighWaterSpring,
                       suspendedSediment = input$suspendedSediment,
                       lunarNodalAmp = input$lunarNodalAmp,
                       bMax = input$bMax,
                       zVegMin = input$vegElevRange[1],
                       zVegMax = input$vegElevRange[2],
                       zVegPeak = input$zVegPeak,
                       plantElevationType = input$planeElevationType,
                       rootToShoot = input$rootToShoot,
                       rootTurnover = input$rootTurnover,
                       rootDepthMax = input$rootDepthMax,
                       shape = input$shape,
                       omDecayRate = input$omDecayRate,
                       recalcitrantFrac= input$recalcitrantFrac,
                       settlingVelocity = input$settlingVelocity,
                       omPackingDensity = input$omPackingDensity,
                       mineralPackingDensity = input$mineralPackingDensity,
                       rootPackingDensity = input$rootPackingDensity,
                       coreYear = input$coreYear,
                       coreDepth = input$coreDepth,
                       coreMaxs = 1:input$coreDepth,
                       coreMins = 1:input$coreDepth-1)
    #print(inputParms)
    return(inputParms)
  })
  
  
  # Run the function runMemWithCohorts with GUI inputs
  runSim <- eventReactive(input$run_sim, {
    do.call(rCTM::runMemWithCohorts, getParms())
  })
  
  # Run "makePlots"
  graphs <- eventReactive(input$run_sim, {
    modelOutput <- do.call(rCTM::runMemWithCohorts, getParms())
    #print(modelOutput)
    makePlots(modelOutput)
  })  
  
  # Render Plots for UI window
  output$plot1 <- renderPlot({
    graphs()$plot1
  })
  output$plot2 <- renderPlot({
    graphs()$plot2
  })
  output$plot3 <- renderPlot({
    graphs()$plot3
  })
  output$plot4 <- renderPlot({
    graphs()$plot4
  })
  output$plot5 <- renderPlot({
    graphs()$plot5
  })
  output$plot6 <- renderPlot({
    graphs()$plot6
  })
  
})