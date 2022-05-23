#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(readr)
library(dplyr)
library(leaflet)
library(sf)
library(rmapshaper)
library(prettydoc)
library(plotly)
library(scales)

# Importation des datasets

data2015 <- tibble(read_csv('../data/2015.csv'))
data2016 <- tibble(read_csv('../data/2016.csv'))
data2017 <- tibble(read_csv('../data/2017.csv'))
data2018 <- tibble(read_csv('../data/2018.csv'))
data2019 <- tibble(read_csv('../data/2019.csv'))
data2020 <- tibble(read_csv('../data/2020.csv'))
data2021 <- tibble(read_csv('../data/2021.csv'))
countries <- tibble(read_csv('../data/countries.csv'))
world_map <- read_sf('../data/world_map')

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
         Trust_government = `Perceptions of corruption`,
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
         Trust_government = `Perceptions of corruption`,
         Dystopia_score = `Ladder score in Dystopia`,
         Exp_by_economy_gdp_per_capita = `Explained by: Log GDP per capita`,
         Explained_by_social_support = `Explained by: Social support`,
         Explained_by_life_expectancy = `Explained by: Healthy life expectancy`, 
         Explained_by_freedom = `Explained by: Freedom to make life choices`, 
         Explained_by_generosity = `Explained by: Generosity`,
         Explained_by_trust_government = `Explained by: Perceptions of corruption`,
         Dystopia_residual = `Dystopia + residual`)

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


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$countries <- renderTable(unique(data$Country))
  
  output$happiness_score_country_evolution <- renderPlot(
    data %>%
      filter(Country == input$country) %>%
      ggplot(aes(x = Year, y = Happiness_score)) + geom_line(stat = "identity")
  )

})
