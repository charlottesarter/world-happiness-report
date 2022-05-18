#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("year",
                        "Année",
                        list(2015, 2016, 2017, 2018, 2019, 2020, 2021))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("happinessPerCountry")
        )
    )
))
