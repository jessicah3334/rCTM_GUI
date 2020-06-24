#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
#library(rCTM)
  # currently using local functios for debugging purposes

# Define server logic
shinyServer(function(input, output) {
  
#Make a reactive function to populate inputParms
  getParms <- reactive({
    
    inputParms <- list(startYear = input$startYear, endYear = input$endYear, relSeaLevelRiseInit = input$relSeaLevelRiseInit, relSeaLevelRiseTotal = 100,
                       initElv = input$initElev, meanSeaLevel = input$meanSeaLevel, meanSeaLevelDatum = input$meanSeaLevelDatum, meanHighWater = input$meanHighWater,
                       meanHighHighWater = input$meanHighHighWater, meanHighHighWaterSpring = input$meanHighHighWaterSpring, suspendedSediment = input$suspendedSediment,
                       lunarNodalAmp = input$lunarNodalAmp, bMax = input$bMax, zVegMin = input$zVegMin, zVegMax = input$zVegMax, zVegPeak = input$zVegPeak,
                       plantElevationType = input$planeElevationType, rootToShoot = input$rootToShoot, rootTurnover = input$rootTurnover, rootDepthMax = input$rootDepthMax,
                       shape = input$shape, omDecayRate = input$omDecayRate, recalcitrantFrac= input$recalcitrantFrac, settlingVelocity = input$settlingVelocity,
                       omPackingDensity = input$omPackingDensity, mineralPackingDensity = input$mineralPackingDensity, rootPackingDensity = input$rootPackingDensity,
                       coreYear = input$coreYear, coreDepth = input$coreDepth, coreMaxs = 1:input$coreDepth, coreMins = 1:input$coreDepth-1)
    print(inputParms)
    return(inputParms)
  })
  
  
# Run the function runMemWithCohorts with GUI inputs
  runSim <- eventReactive(input$run_sim, {
    do.call(runMemWithCohorts, getParms())
  })

# Run "makePlots" and add plots to GUI window
  makePlots <- eventReactive(input$run_sim, {
    modelOutput <- do.call(runMemWithCohorts, getParms())
    source(R/makePlots.R)
    makePlots.R(modelOutput)
  })  
  
  output$plot1 <- renderPlot({
    makePlots()$plot1
  })
  
  output$plot2 <- renderPlot({
    makePlots()$plot2
  })
  
})
