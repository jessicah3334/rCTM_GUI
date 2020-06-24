#' Make plots for the rCTM model
#' 
#' This function delivers a set of standard plots for the Marsh Equilibrium Cohort model.
#'
#' @param modelOutput A list of three data frames. Contains output of the function "runMemWithCohorts".
#'
#' @importFrom dplyr rename starts_with mutate group_by summarize filter if_else
#' @importFrom tidyr separate  pivot_longer
#' @import ggplot2
#' 
#' @return a list of 6 plots similar to those in MEM 3.4 
#' 
#' @export
#'
makePlots <- function(sim.df){
  ans <- list(
    plot1= #A plot of Standing biomass vs Marsh Elevation
      ggplot(modelOutput[1], aes(x=surfaceElevation, y=biomass)) +
      geom_line(),
 
    plot2= #A plot of standing biomass vs time
      ggplot(modelOutput[1], aes(x=years, y=biomass)) +
      geom_line()
  )
  
  
  return(ans)
}