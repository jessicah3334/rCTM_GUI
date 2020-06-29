#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(shinydashboard)
library(rCTM)

shinyUI(fluidPage(dashboardPage(
    skin = "green",
    title = "Marsh Equilibrium Cohort Model v",

# HEADER ---------------------------------------------------------------------
    dashboardHeader(
        title = "Marsh Equilibrium Cohort Model v",
        titleWidth = 500
    ),

# SIDEBAR --------------------------------------------------------------------
    dashboardSidebar(
        width = 350,
        fluidRow(
            column(4,
                   actionButton("run_sim", "Run Simulation")),
            column(6,
                   actionButton("restore_inputs", "Restore Inputs"))),
        menuItem(
            "OPTIONS",
            tabName = "Options",
            icon = icon("spinner")
        ),
        menuItem(
            "PHYSICAL INPUTS",
            tabName = "Physical Inputs",
            icon = icon("spinner"),
            sliderInput("startYear", "Start Year", 1500, 2500, 2020),
            sliderInput("endYear", "End Year", 1500, 2500, 2119),
            sliderInput("rslrTotal", "Century Sea Level Rise", 0, 100, 100),
            sliderInput("relSeaLevelRiseInit", "Initial Sea Level Rise", 0, 10, 0.3),
            sliderInput("meanHighWater", "Mean High Water", 0, 999, 16.9),
            sliderInput("meanHighHighWater", "Mean High High Water", 0, 999, 25.4),
            sliderInput("meanHighHighWaterSpring", "Mean High High Water Spring", 0, 999, 31.2),
            sliderInput("meanSeaLevelDatum", "Mean Sea Level", 0, 999, 7.4),
            sliderInput("settlingVelocity", "Settling Velocity", 0, 999, 2.8),
            sliderInput("lunarNodalAmp", "Lunar Nodal Amp", 0, 999, 2.5),
            sliderInput("meanSeaLevel", "Initial Rate SLR", 0, 999, 7.4),
            sliderInput("suspendedSediment", "Susp. Sediment Conc.", 0, 1, 3e-05),
            sliderInput("initElev", "Marsh Elevation", 0, 999, 21.9),
            sliderInput("coreYear", "Core Year", 0, 9999, 2050),
            sliderInput("coreDepth", "Core Depth", 0, 999, 100),
            sliderInput("coreMaxs", "Core Max", 0, 999, 999),
            sliderInput("coreMins", "Core Mins", 0, 999, 999)
        ),
        menuItem(
            "BIOLOICAL INPUTS",
            tabName = "Biological Inputs",
            icon = icon("spinner"),
            sliderInput("zVegMax", "Max Veg. Elev.", 0, 999, 44.4),
            sliderInput("zVegMin", "Min Veg. Elev.", -30, 999, -24.7),
            sliderInput("zVegPeak", "Peak Veg. Elev.", 0, 999, 22.1),
            sliderInput("bMax", "Max Biomass", 0, 999, 0.25),
            sliderInput("omDecayRate", "OM Decay Rate", 0, 999, 0.8),
            sliderInput("rootToShoot", "Root to Shoot Ratio", 0, 999, 2),
            sliderInput("rootTurnover", "BG Turnover Rate", 0, 999, 0.5),
            sliderInput("rootDepthMax", "Max (95%) Root Depth", 0, 999, 30),
            sliderInput("omPackingDensity", "Organic Packing Density", 0, 1, 0.085),
            sliderInput("mineralPackingDensity", "Mineral Packing Density", 0, 2, 1.99),
            sliderInput("rootPackingDensity", "Root Packing Density", 0, 1, 0.085),
            selectInput("planeElevationType", "Plant Elevation Type", c("orthometric", "dimensionless")),
            selectInput("shape", "Root Shape", c("linear", "exponential"))
        ),
        menuItem(
            "MODEL DERIVED INPUTS",
            tabName = "Model Derived Inputs",
            icon = icon("spinner"),
            sliderInput("recalcitrantFrac", "Recalcitrant Fraction", 0, 1, 0.2)
        )
    
        
    ),

# MAIN PANEL -----------------------------------------------------------------
    dashboardBody(
        
    )
)))