# Crosstalk: Shiny-like without Shiny (EARL 18, London, Sep 2018)
# Blurb: https://earlconf.com/2018/london/#matt-dray
# Matt Dray
# July 2018

# This file: create a leaflet html file

# Leaflet for R: https://rstudio.github.io/leaflet/


# Prep workspace ----------------------------------------------------------


sch <- readRDS("data/gias_sample.RDS")
library(dplyr)  # tidy data manipulation
library(leaflet)  # interative mapping


# Map ---------------------------------------------------------------------

map <- sch %>% 
  leaflet::leaflet() %>%
  leaflet::addProviderTiles(providers$OpenStreetMap) %>% 
  leaflet::addAwesomeMarkers(
    popup = ~paste0(
      "<h3>", sch$sch_name, "</h3>",
      
      "<table style='width:100%'>",
      
      "<tr>",
      "<th>URN</th>",
      "<th>", sch$sch_urn, "</th>",
      "</tr>",
      
      "<tr>",
      "<tr>",
      "<th>Phase</th>",
      "<th>", sch$sch_phase, "</th>",
      "</tr>",
      
      "<tr>",
      "<tr>",
      "<th>Type</th>",
      "<th>", sch$sch_type, "</th>",
      "</tr>",
      
      "<tr>",
      "<tr>",
      "<th>Location</th>",
      "<th>", sch$geo_town, ", ", sch$geo_postcode, "</th>",
      "</tr>",
      
      "<tr>",
      "<tr>",
      "<th>LA</th>",
      "<th>", sch$geo_la, "</th>",
      "</tr>"
    ),  # end popup()
    icon = awesomeIcons(
      library = "ion",
      icon = ifelse(
        test = sch$ofsted_rating == "1 Outstanding",
        yes = "ion-android-star-outline",
        no = "ion-android-radio-button-off"
      ),
      iconColor = "white",
      markerColor = ifelse(
        test = sch$sch_phase == "Primary", 
        yes = "red",
        no = "blue"
      )
    )
  ) %>%   # end addAwesomeMarkers()
leaflet::addMeasure()

print(map)
