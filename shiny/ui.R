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

# on récupère la liste des pays à mettre dans notre select input depuis un csv
countries_names = read_lines("../data/countries_names.csv")

# Define UI for application that draws a histogram

dashboardPage(
  dashboardHeader(title = "Dashboard"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(
        selectInput("country", label = "Sélectionner un pays", choices = countries_names, 
      selected = "Afghanistan")
      ),
      box(
        plotOutput("happiness_score_country_evolution")
      )
    )
  )
)
