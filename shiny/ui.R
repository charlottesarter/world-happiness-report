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
library(readr)
library(leaflet)

# on récupère la liste des pays à mettre dans notre select input depuis un csv
countries_names = read_lines("../data/countries_names.csv")

# Define UI for application that draws a histogram

dashboardPage(
  skin = "purple",
  
  dashboardHeader(title = "World Happiness Report",
                  titleWidth = 300),
  
  dashboardSidebar(
    
    width = 300,
    sidebarMenu(
      menuItem("Bonheur par pays", tabName = "happ_score_by_country", icon = icon("globe")),
      menuItem("Les facteurs de bonheur", tabName = "happ_score_factors", icon = icon("globe")),
      menuItem("Carte du bonheur dans le monde", tabName = "maps", icon = icon("globe"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "happ_score_by_country",
        fluidRow(
          valueBoxOutput("maximum"),
          valueBoxOutput("minimum"),
          valueBoxOutput("average"),
          box(
            width = 8,
            plotOutput("happiness_score_country_evolution")
          ),
          box(
            width = 4,
            selectInput("country", label = "Sélectionner un pays", choices = countries_names, 
                        selected = "Afghanistan")
          ),
        )
      ),
      tabItem(tabName = "happ_score_factors",
        fluidRow(
          box(
            selectInput("country_factors", label = "Sélectionner un pays", choices = countries_names, 
                        selected = "Afghanistan")
          ),
          box(
            radioButtons("year_factors", label = "Sélectionner une année", 
                        choices = c(2015, 2016, 2017, 2018, 2019, 2020, 2021), selected = 2021)
          ),
          box(
            plotOutput("factors_contribution_graph")
          )
        )
      ),
      tabItem(tabName = "maps",
              fluidRow(
                box(
                  leafletOutput("map_happiness_score")
                )
              ),
              fluidRow(
                box(
                  radioButtons("year_map_happiness_score", label = "Sélectionner une année", 
                               choices = c(2015, 2016, 2017, 2018, 2019, 2020, 2021), selected = 2021)
                )
              )
      )
    )
  )
)
