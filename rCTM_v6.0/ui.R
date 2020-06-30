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
library(gganimate)
#Currently sourcing R scripts manually:
    #source("./R/makePlots.R")

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
        sidebarMenu(
        id = "tabs",
        fluidRow(
            column(1),
            column(4,
                   actionButton("run_sim", "Run Simulation")),
            column(4,
                   actionButton("restore_inputs", "Restore Inputs"))),
        menuItem(
            "INPUTS",
            tabName = "Inputs",
            icon = icon("sliders-h"),
            selected = TRUE
        ),
        menuItem(
            "OPTIONS",
            tabName = "Options",
            icon = icon("cog")
        ),
        menuItem(
            "PLOTS",
            tabName = "Plots",
            icon = icon("chart-line")
        ),
        menuItem(
            "ANIMATION",
            tabName = "Animation",
            icon = icon("eye")
        ),
        menuItem(
            "MODEL DIAGRAM",
            tabName = "Model Diagram",
            icon = icon("project-diagram")
        ),
        menuItem(
            "PARAMETER RANGES",
            tabName = "Parameter Ranges",
            icon = icon("clipboard-list")
        ),
        menuItem(
            "R CODE FOR PARAMETERIZATION",
            tabName = "R Code For Parameterization",
            icon = icon("download")
        )
        
    
        
    )),

# MAIN PANEL -----------------------------------------------------------------
    dashboardBody(tabItems(
        tabItem(tabName = "Inputs",
            box(title = "Physical Inputs",
                width = 12,
                collapsible = TRUE,
                fluidRow(
                    column(width = 4,
                           sliderInput("dateRange", "Date Range", 1500, 2500, c(2020,2119), step = 1, sep = ""),
                           sliderInput("relSeaLevelRiseTotal", "Century Sea Level Rise", 0, 100, 100),
                           sliderInput("relSeaLevelRiseInit", "Initial Sea Level Rise", 0, 10, 0.3, step = 0.1),
                           sliderInput("meanHighWater", "Mean High Water", 0, 999, 16.9, step = 0.1),
                           sliderInput("meanSeaLevelDatum", "Mean Sea Level", 0, 999, 7.4, step = 0.1)
                    ),
                    column(width = 4,
                           sliderInput("meanSeaLevel", "Initial Rate SLR", 0, 999, 7.4, step = 0.1),
                           sliderInput("settlingVelocity", "Settling Velocity", 0, 999, 2.8, step = 0.1),
                           sliderInput("lunarNodalAmp", "Lunar Nodal Amp", 0, 999, 2.5, step = 0.1),
                           sliderInput("suspendedSediment", "Susp. Sediment Conc.", 0, .001, 3e-05, step = 0.00001),
                           sliderInput("initElev", "Marsh Elevation", 0, 999, 21.9, step = 0.1)
                    ),
                    column(width = 4,
                           sliderInput("coreYear", "Core Year", 0, 9999, 2050, sep = ""),
                           sliderInput("coreDepth", "Core Depth", 0, 999, 100),
                           #sliderInput("coreRange", "Core Range", 0, 999, c(0,999)),
                           sliderInput("recalcitrantFrac", "Recalcitrant Fraction", 0, 1, 0.2, step = 0.1)
                    ),
                )
            ),
            box(title = "Biological Inputs",
                width = 12,
                collapsible = TRUE,
                fluidRow(
                    column(width = 4,
                           sliderInput("vegElevRange", "Plant Growing Elevation Range", -30, 999, c(-24.7,44.4), step = 0.1),
                           sliderInput("bMax", "Maximum Biomass", 0, 999, 0.25, step = 0.01),
                           sliderInput("omDecayRate", "Organic Matter Decay Rate", 0, 999, 0.8, step = 0.1),
                           sliderInput("rootToShoot", "Root to Shoot Ratio", 0, 999, 2) 
                    ),
                    column(width = 4,
                           sliderInput("rootTurnover", "BG Turnover Rate", 0, 999, 0.5, step = 0.1),
                           sliderInput("rootDepthMax", "Max (95%) Root Depth", 0, 999, 30),
                           sliderInput("omPackingDensity", "Organic Matter Packing Density", 0, 1, 0.085, step = 0.001),
                           sliderInput("mineralPackingDensity", "Mineral Packing Density", 0, 2, 1.99, step = 0.01)
                    ),
                    column(width = 4,
                           sliderInput("rootPackingDensity", "Root Packing Density", 0, 1, 0.085, step = 0.001),
                           selectInput("planeElevationType", "Plant Elevation Type", c("orthometric", "dimensionless")),
                           selectInput("shape", "Root Shape", c("linear", "exponential"))
                    )
                ),
            ),
            box(title = "Optional Inputs",
                width = 12,
                collapsible = TRUE,
                fluidRow(
                    column(width = 4,
                           sliderInput("meanHighHighWater", "Mean High High Water", 0, 999, 25.4, step = 0.1) 
                    ),
                    column(width = 4,
                           sliderInput("meanHighHighWaterSpring", "Mean High High Water Spring", 0, 999, 31.2, step = 0.1)  
                    ),
                    column(width = 4,
                           sliderInput("zVegPeak", "Peak Veg. Elev.", 0, 999, 22.1, step = 0.1)
                    )
                )
            )    
                
        ),
        tabItem(tabName = "Plots",
            box(title = "Plots",
                width = 12,
                fluidRow(
                    column(width = 6,
                           plotOutput("plot1", height = '200px'),
                           plotOutput("plot2", height = '200px'),
                           plotOutput("plot3", height = '200px')
                           ),
                    column(width = 6,
                           plotOutput("plot4", height = '200px'),
                           plotOutput("plot5", height = '200px'),
                           plotOutput("plot6", height = '200px')
                           )
                )
            )
        ),
        
        tabItem(tabName = "Animation",
                box(width = 12,
                    imageOutput("gif")
                    )
                ),
        tabItem(tabName = "Model Diagram",
                box(width = 12,
                    
                    )
                ),
        tabItem(tabName = "Parameter Ranges",
                box(width = 12,
                    
                    )
                ),
        tabItem(tabName = "R Code for Parameterizationss",
                  box(width = 12,
                      
                  )
                )
        
    ))# Close main panel

)))# Close function