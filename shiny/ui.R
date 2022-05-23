#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram

dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(
        selectInput("country", label = "Sélectionner un pays", choices = list("Afghanistan" = "Afghanistan", "Albania" = "Albania", "Argentina" = "Argentina"), 
      selected = "Afghanistan")
      ),
      box(
        plotOutput("happiness_score_country_evolution")
      )
    )
  )
)
