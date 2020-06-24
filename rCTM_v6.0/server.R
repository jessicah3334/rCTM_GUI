#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(rCTM)

# Define server logic
shinyServer(function(input, output) {
  
#Make a reactive function to populate inputParms
  getParms <- reactive({
    
    inputParms <- list(startYear = input$startYear, endYear = input$endYear, relSeaLevelRiseInit = input$relSeaLevelRiseInit, rslrTotal = 100,
                       initElv = input$initElev, meanSeaLevel = input$meanSeaLevel, meanSeaLevelDatum = input$meanSeaLevelDatum, meanHighWater = input$meanHighWater,
                       meanHighHighWater = input$meanHighHighWater, meanHighHighWaterSpring = input$meanHighHighWaterSpring, suspendedSediment = input$suspendedSediment,
                       lunarNodalAmp = input$lunarNodalAmp, bMax = input$bMax, zVegMin = input$zVegMin, zVegMax = input$zVegMax, zVegPeak = input$zVegPeak,
                       plantElevationType = input$planeElevationType, rootToShoot = input$rootToShoot, rootTurnover = input$rootTurnover, rootDepthMax = input$rootDepthMax,
                       shape = input$shape, omDecayRate = input$omDecayRate, recalcitrantFrac= input$recalcitrantFrac, settlingVelocity = input$settlingVelocity,
                       omPackingDensity = input$omPackingDensity, mineralPackingDensity = input$mineralPackingDensity, rootPackingDensity = input$rootPackingDensity,
                       coreYear = input$coreYear, coreDepth = input$coreDepth, coreMaxs = input$coreMaxs, coreMins = input$coreMins)
    print(inputParms)
    return(inputParms)
  })
  
  
#run the function runMemWithCohorts with GUI inputs
  runSim <- eventReactive(input$run_sim, {
    do.call(rCTM::runMemWithCohorts, getParms())
  })
  
  
})
