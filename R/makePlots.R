#' Make plots for the rCTM model
#' 
#' This function delivers a set of standard plots for the Marsh Equilibrium Cohort model.
#'
#' @param modelOutput A list of three data frames. Contains output of the function "runMemWithCohorts".
#'
#' @importFrom dplyr rename starts_with mutate group_by summarize filter if_else
#' @importFrom tidyr separate  pivot_longer
#' @import ggplot2 to make pretty plots
#' 
#' @return a list of 6 plots similar to those in MEM 3.4 
#' 
#' @export
#'
makePlots <- function(modelOutput){
  ans <- list(
    plot1= #A plot of Standing biomass vs Marsh Elevation ---------------------
      ggplot(modelOutput$annualTimeSteps,
             aes(x=surfaceElevation, y=biomass)) +
      labs(x="Marsh Elevation (cm)", y="Standing Biomass (g/m2)") +
      geom_line(),
 
    plot2= #A plot of standing biomass vs time ---------------------------------
      ggplot(modelOutput$annualTimeSteps,
             aes(x=years, y=biomass)) +
      labs(x="time (yrs)", y="Standing Biomass (g/m2)") +
      geom_line(),
    
    plot3= #A plot of Depth vs Time --------------------------------------------
      ggplot(modelOutput$annualTimeSteps,
             aes(x=years, y=meanHighWater-surfaceElevation)) +
      labs(x="time (yrs)", y="Depth (cm below Mean High Water)") +
      geom_line(),
      
    plot4= #A plot of Marsh Elevation compared to Mean Sea Level over time ----
      ggplot(modelOutput$annualTimeSteps) +
      labs(x="time (yrs)", y="(cm NAVD)" ) +
      geom_line(aes(x=years, y=surfaceElevation, color = "Surface Elevation")) +
      geom_line(aes(x=years, y=meanSeaLevel, color = "Mean Sea Level")) +
      theme(legend.justification=c(0,1), legend.position=c(0,1)),
      
    plot5= #A plot of Sediment Organic matter vs Sediment depth -----------------
      ggplot() +
      labs(x="Sediment Depth (cm)", y="Sediment Organic Matter (%)") +
      geom_line(),
      
    plot6= #A plot of Marsh Accretion over time --------------------------------
      ggplot(modelOutput$annualTimeSteps,
             aes(x=years, y=)) +
      labs(x="time (yrs)", y="Marsh Accretion (tons C/(ha yr))") +
      geom_line()
    )
  
  return(ans)
}
