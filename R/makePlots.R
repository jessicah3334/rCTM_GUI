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
  #calculate OM fraction for modelOutput$cohorts
  modelOutput$cohorts <- modelOutput$cohorts %>% 
    dplyr::mutate(om_fraction = (fast_OM+slow_OM)/cumCohortVol)
  
  #Find change in carbon stock over time by taking the numerical derivative
  modelOutput$cohorts <- modelOutput$cohorts %>%
    dplyr::mutate(dcdt = rep(NA, times = nrow(modelOutput$cohorts)))
                    
  carbon <- rep(NA, times = nrow(modelOutput$cohorts))
  for(ii in 1:nrow(modelOutput$cohorts)){
        carbon[ii] <- modelOutput$cohorts$fast_OM[ii] + modelOutput$cohorts$slow_OM[ii]
  }
  for(ii in 1:nrow(modelOutput$cohorts)){
        modelOutput$cohorts$dcdt[ii] <- (carbon[ii+1] - carbon[ii]) / (modelOutput$cohorts$age[ii+1] - modelOutput$cohorts$age[ii])
  }
                
  
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
      
    plot5= #A plot of Carbon stock per volume vs depth -------------------------
      ggplot(modelOutput$cohorts,
             aes(x=layer_top, y=om_fraction)) +
      labs(x="Sediment Depth (cm)", y="Sediment Organic Matter (%)") +
      geom_smooth(),
      
    plot6= #A plot of Marsh Accretion over time (change in carbon stock over time)
      ggplot(modelOutput$cohorts,
             aes(x=year, y=dcdt)) +
      labs(x="time (yrs)", y="Change in Carbon Stock (g/m^2 year") +
      ylim(-.001, .001) +
      geom_point()
    )
  print(modelOutput$cohorts$dcdt)
  
  return(ans)
}
