#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(leaflet)
library(sf)
library(rmapshaper)
library(prettydoc)
library(plotly)
library(scales)
library(data.table)
library(knitr)
library(RColorBrewer)
library(gapminder)

# Import des datasets

data2015 <- tibble(read_csv('../data/2015.csv'))
data2016 <- tibble(read_csv('../data/2016.csv'))
data2017 <- tibble(read_csv('../data/2017.csv'))
data2018 <- tibble(read_csv('../data/2018.csv'))
data2019 <- tibble(read_csv('../data/2019.csv'))
data2020 <- tibble(read_csv('../data/2020.csv'))
data2021 <- tibble(read_csv('../data/2021.csv'))
complement2021 <- tibble (read_csv('../data/complement_2021.csv'))
countries <- tibble(read_csv('../data/countries.csv'))
world_map <- read_sf('../data/world_map')
continents <- read_csv('../data/continents.csv')

# Nettoyage du dataset "countries" pour pouvoir ajouter les coordonnées géographiques des pays

countries_corrected <- countries %>%
  rename(Country_code =`country`, 
         Latitude = `latitude`,
         Longitude = `longitude`,
         Country = `name`)

# Nettoyage du dataset "world_map" pour pouvoir manipuler les régions du monde sur une carte

world_map_corrected <- world_map %>%
  rename(Country =`NAME`, 
         Geometry = `geometry`)

# Renommage des colonnes (selon la convention définie précedemment) & ajout de la colonne "year" 

data2015_corrected <- data2015 %>% 
  mutate(lower_confidence_interval = `Happiness Score` - `Standard Error`, upper_confidence_interval = `Happiness Score` + `Standard Error`, Year = 2015) %>%
  rename(Happiness_rank =`Happiness Rank`, 
         Happiness_score = `Happiness Score`,
         Standard_error = `Standard Error`,
         Exp_by_economy_gdp_per_capita = `Economy (GDP per Capita)`,
         Explained_by_social_support = Family,
         Explained_by_life_expectancy = `Health (Life Expectancy)`,
         Explained_by_freedom = Freedom,
         Explained_by_trust_government = `Trust (Government Corruption)`,
         Explained_by_generosity = Generosity,
         Dystopia_residual = `Dystopia Residual`)
data2015_corrected$Exp_by_economy_gdp_per_capita <- as.double(data2015_corrected$Exp_by_economy_gdp_per_capita)

data2016_corrected <- data2016 %>% 
  mutate(Standard.Error = `Happiness Score` - `Lower Confidence Interval`, Year = 2016) %>%
  rename(Happiness_rank = `Happiness Rank`, 
         Happiness_score = `Happiness Score`,
         Standard_error = Standard.Error,
         Exp_by_economy_gdp_per_capita = `Economy (GDP per Capita)`,
         Explained_by_social_support = Family,
         Explained_by_life_expectancy = `Health (Life Expectancy)`,
         Explained_by_freedom = Freedom,
         Explained_by_trust_government = `Trust (Government Corruption)`,
         Explained_by_generosity = Generosity,
         Dystopia_residual = `Dystopia Residual`,
         Lower_confidence_interval = `Lower Confidence Interval`,
         Upper_confidence_interval = `Upper Confidence Interval`)
data2016_corrected$Exp_by_economy_gdp_per_capita <- as.double(data2016_corrected$Exp_by_economy_gdp_per_capita)

data2017_corrected <- data2017 %>% 
  mutate(Standard_error = Happiness.Score - Whisker.low, Year = 2017) %>%
  rename(Happiness_rank = Happiness.Rank, 
         Happiness_score = Happiness.Score,
         Exp_by_economy_gdp_per_capita = Economy..GDP.per.Capita.,
         Explained_by_social_support = Family,
         Explained_by_life_expectancy = Health..Life.Expectancy.,
         Explained_by_freedom = Freedom,
         Explained_by_trust_government = Trust..Government.Corruption.,
         Explained_by_generosity = Generosity,
         Dystopia_residual = Dystopia.Residual,
         Lower_confidence_interval = Whisker.low,
         Upper_confidence_interval = Whisker.high)

# on n'a pas l'information de l'erreur standard pour 2018
data2018_corrected <- data2018 %>%
  mutate(Year = 2018) %>%
  rename(Country = `Country or region`, 
         Happiness_score = Score, 
         Happiness_rank = `Overall rank`,
         Exp_by_economy_gdp_per_capita = `GDP per capita`,
         Explained_by_freedom = `Freedom to make life choices`, 
         Explained_by_trust_government = `Perceptions of corruption`, 
         Explained_by_social_support = `Social support`,
         Explained_by_life_expectancy = `Healthy life expectancy`,
         Explained_by_generosity = Generosity) %>% 
  mutate(Explained_by_trust_government = as.double(Explained_by_trust_government))

data2019_corrected <- data2019 %>%
  mutate(Year = 2019) %>%
  rename(Country =`Country or region`, 
         Happiness_score = Score, 
         Happiness_rank = `Overall rank`,
         Exp_by_economy_gdp_per_capita = `GDP per capita`,
         Explained_by_freedom = `Freedom to make life choices`, 
         Explained_by_trust_government = `Perceptions of corruption`, 
         Explained_by_social_support = `Social support`,
         Explained_by_life_expectancy = `Healthy life expectancy`,
         Explained_by_generosity = Generosity) 

data2020_corrected <- data2020 %>%
  mutate(Year = 2020) %>%
  rename(Happiness_score = `Ladder score`, 
         Country = `Country name`, 
         Regional_indicator = `Regional indicator`,
         Standard_error = `Standard error of ladder score`,
         Lower_confidence_interval = lowerwhisker, 
         Upper_confidence_interval = upperwhisker, 
         Logged_gpd_per_capita = `Logged GDP per capita`,
         Social_support = `Social support`,
         Life_expectancy = `Healthy life expectancy`,
         Freedom = `Freedom to make life choices`,
         Perceptions_of_corruption = `Perceptions of corruption`,
         Dystopia_score = `Ladder score in Dystopia`,
         Exp_by_economy_gdp_per_capita = `Explained by: Log GDP per capita`,
         Explained_by_social_support = `Explained by: Social support`,
         Explained_by_life_expectancy = `Explained by: Healthy life expectancy`, 
         Explained_by_freedom = `Explained by: Freedom to make life choices`, 
         Explained_by_generosity = `Explained by: Generosity`,
         Explained_by_trust_government = `Explained by: Perceptions of corruption`,
         Dystopia_residual = `Dystopia + residual`)

data2021_corrected <- data2021 %>%
  mutate(Year = 2021) %>%
  rename(Happiness_score = `Ladder score`, 
         Country = `Country name`, 
         Regional_indicator = `Regional indicator`,
         Standard_error = `Standard error of ladder score`,
         Lower_confidence_interval = lowerwhisker, 
         Upper_confidence_interval = upperwhisker, 
         Logged_gpd_per_capita = `Logged GDP per capita`,
         Social_support = `Social support`,
         Life_expectancy = `Healthy life expectancy`,
         Freedom = `Freedom to make life choices`,
         Perceptions_of_corruption = `Perceptions of corruption`,
         Dystopia_score = `Ladder score in Dystopia`,
         Exp_by_economy_gdp_per_capita = `Explained by: Log GDP per capita`,
         Explained_by_social_support = `Explained by: Social support`,
         Explained_by_life_expectancy = `Explained by: Healthy life expectancy`, 
         Explained_by_freedom = `Explained by: Freedom to make life choices`, 
         Explained_by_generosity = `Explained by: Generosity`,
         Explained_by_trust_government = `Explained by: Perceptions of corruption`,
         Dystopia_residual = `Dystopia + residual`)

# On ajoute le ranking des pays pour 2021 au dataset

data2021_corrected$Happiness_rank <- rank(-data2021_corrected$Happiness_score)

# Création et ajout du dataset supplémentaire à 2021

cities <- read_csv2('data/city.csv')

complement2021 <- merge(complement2021, cities, by="City")

data2021_complement <- merge(complement2021,data2021_corrected, by="Country")

data2021_complement <- data2021_complement %>%
  rename (Sunshine_time='Sunshine hours(City)',
          Water_price_sterling = 'Cost of a bottle of water(City)',
          Obesity_level_pourcent ='Obesity levels(Country)',
          Pollution_score='Pollution(Index score) (City)',
          Annual_work_time='Annual avg. hours worked',
          Outdoor_activities='Outdoor activities(City)',
          Number_of_takeout_places ='Number of take out places(City)',
          Gym_monthlycost_sterling='Cost of a monthly gym membership(City)')

# Supression des colonnes doubles pour data2021_complement

data2021_complement <- data2021_complement[,-7]
data2021_complement <- data2021_complement[,-9]

# Retrait de l'unité dans les colonnes pour data2021_complement

data2021_complement$Water_price <- sub("£","",data2021_complement$Water_price)
data2021_complement$Gym_monthlycost <- sub("£","",data2021_complement$Gym_monthlycost)
data2021_complement$Obesity_level <- sub("%","",data2021_complement$Obesity_level)

# Modification du type en numeric

data2021_complement$Sunshine_time <- as.numeric(data2021_complement$Sunshine_time)
data2021_complement$Water_price <- as.numeric(data2021_complement$Water_price)
data2021_complement$Obesity_level <- as.numeric(data2021_complement$Obesity_level)
data2021_complement$Pollution_score <- as.numeric(data2021_complement$Pollution_score)
data2021_complement$Annual_work_time <- as.numeric(data2021_complement$Annual_work_time)
data2021_complement$Gym_monthlycost <- as.numeric(data2021_complement$Gym_monthlycost)

# Fusion de tous les datasets

data <- data2015_corrected %>% 
  bind_rows(data2016_corrected) %>% 
  bind_rows(data2017_corrected) %>%
  bind_rows(data2018_corrected) %>%
  bind_rows(data2019_corrected) %>%
  bind_rows(data2020_corrected) %>%
  bind_rows(data2021_corrected)

# Complétion de la colonne "Region"

regions <- data2015_corrected %>% select("Country", "Region")

data <- merge(data, regions, by="Country")

data <- data %>% select(-"Region.x")
data <- data %>% rename("Region"="Region.y")

# Ajout des coordonnées géographiques

data <- merge(data, countries_corrected, by="Country")

# Ajout des données géographiques (shapefile)

data <- merge(data, world_map_corrected, by="Country")

# Ajout des continents 

data <- merge(data, continents, by="Country")


# Création de la fonction de palette numérique sur les scores de bonheur

mybins <- c(0,2,3,4,5,6,7,8)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$countries <- renderTable(unique(data$Country))
  
  output$happiness_score_country_evolution <- renderPlot(
    data %>%
      filter(Country == input$country) %>%
      ggplot(aes(x = Year, 
                 y = Happiness_score)) + 
      geom_point() +
      geom_line(stat = "identity", 
                color = "mediumpurple") + 
      labs(title = paste("Evolution du bonheur: ", input$country), 
           x = "Année", 
           y = "Score de bonheur")
  )

  output$factors_contribution_graph <- renderPlot(
    data %>%
      filter(Country == input$country_factors) %>%
      filter(Year == strtoi(input$year_factors)) %>%
      select(Exp_by_economy_gdp_per_capita, Explained_by_generosity, Explained_by_life_expectancy, Explained_by_freedom, Explained_by_social_support, Explained_by_trust_government) %>%
      
      # on transpose le dataframe et on le passe en Tibble
      t() %>%
      tibble() %>%
      mutate(Factor_names = c("GPD", "Generosity", "Life expectancy", "Freedom", "Social support", "Trust in government")) %>%
      rename(Factor_values = ".") %>%
      
      # construction du graphique
      ggplot(aes(x = reorder(Factor_names, desc(Factor_values)), 
                 y = Factor_values)) + 
      geom_bar(stat = "identity", 
               fill = "mediumpurple") + 
      labs(title = "Classement des facteurs de bonheur d'un pays", 
           x = "Facteurs de bonheur", 
           y = "Valeur")
  )
  
  data_map_countries <- reactive(data %>% filter(Year == input$year_map_happiness_score))
  
  mypalette <- reactive(colorBin(
    palette = "BuPu", 
    domain = data_map_countries()$Happiness_score, 
    na.color = "transparent",
    bins = mybins))
  
  labels <- reactive(sprintf(
    "<strong>%s</strong><br/>Rank:  %g<br/>Happiness Score: %g",
    data_map_countries()$Country, data_map_countries()$Happiness_rank, data_map_countries()$Happiness_score
  )) %>% 
  
  output$map_happiness_score <- renderLeaflet(
    leaflet() %>%
      addTiles() %>%
      # polygone des pays
      addPolygons(data = data_map_countries()$Geometry,
                  fillColor = mypalette()(data_map_countries()$Happiness_score),
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  fillOpacity = 0.8,
                  label = labels(),
                  highlightOptions = highlightOptions(
                    weight = 5,
                    color = "#666",
                    fillOpacity = 0.7,
                    bringToFront = TRUE)
      ) %>%
      addLegend("bottomright",
                pal = mypalette(), 
                values = data_map_countries()$Happiness_score,
                title = "Score de bonheur",
                opacity = 1
      )
  )

})
