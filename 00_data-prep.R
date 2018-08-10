# Crosstalk: Shiny-like without Shiny (EARL 18, London, Sep 2018)
# Blurb: https://earlconf.com/2018/london/#matt-dray
# Matt Dray
# July 2018

# This file: get and prepare data for use in a series of outputs thst show the
# progression of solutions to a policy need in my department.


# Packages ----------------------------------------------------------------


library(data.table)  # used for fast file read
library(dplyr)  # tidy data manipulation
library(janitor)  # additional tidy functions
library(sf)  # tidy spatial dataframes
library(skimr)  # nice df summaries


# Get data ----------------------------------------------------------------


# Data will be stored in the workspace and not saved to this repo

# Fetch latest cut of Get Information About Schools, a published source of basic
# schools data: https://get-information-schools.service.gov.uk/

# Warning: approx 54 MB

gias <- data.table::fread(  # fast read with progress bar
  paste0(
    "http://ea-edubase-api-prod.azurewebsites.net/edubase/edubasealldata",
    stringr::str_replace_all(Sys.Date(), "-", ""),
    ".csv"
  ),
  na.strings = c("", " ")  # strings that should be considered NA
)  # 46,992 rows, 133 columns at 31 July 2018


# Prepare data ------------------------------------------------------------


# Simplify col names, retain cols of interest, ensure all rows are complete
# These selections are arbitrary and not related to any policies

gias_cut <- gias %>% 
  janitor::clean_names() %>% 
  dplyr::filter(
    establishmentstatus_name == "Open",
    phaseofeducation_name %in% c("Primary", "Secondary")
  ) %>% 
  select(
    # school
    sch_urn = urn,
    sch_name = establishmentname,
    sch_type = typeofestablishment_name,
    sch_type_group = establishmenttypegroup_name,
    sch_phase = phaseofeducation_name,
    # ofsted
    ofsted_rating = ofstedrating_name,
    ofsted_date = ofstedlastinsp,
    # pupils
    pup_count = numberofpupils,
    pup_gender = gender_name,
    pup_percent_fsm = percentagefsm,
    # geography
    geo_town = town,
    geo_postcode = postcode,
    geo_la = la_name,
    geo_easting = easting,
    geo_northing = northing,
    geo_urban_rural = urbanrural_name,
    geo_rsc_region = rscregion_name
  ) %>% 
  mutate_at(
    vars(pup_count,pup_percent_fsm,geo_easting,geo_northing),
    as.numeric  # make all these columns numeric
    ) %>% 
  mutate(
    ofsted_date = lubridate::dmy(ofsted_date),
    sch_urn = as.character(sch_urn)
  ) %>% 
  filter(complete.cases(.))  # only schools with complete info for all columns


# Convert to sf -----------------------------------------------------------

# Convert the dataframe to a spatial dataframe with the sf package
# Create a listcol of latlongs and add spatial metadata

gias_sf <- sf::st_as_sf(
  x = gias_cut,
  coords = c("geo_easting", "geo_northing"),  # columns with coordinates
  crs = 27700  # coordinate reference system code for eastings/northings
) %>% 
  sf::st_transform(crs = 4326)  # the coord ref system code for latlong


# Random sample -----------------------------------------------------------


# Randomly sample 100 schools, half primary, half secondary

set.seed(1337)  # for reproducibility of random selection

gias_sample <- gias_sf %>% 
  group_by(sch_phase) %>%  # half primary, half secondary
  sample_n(50) %>%   # 50 per phase
  ungroup()

# Check the output

glimpse(gias_sample)
View(gias_sample)
skimr::skim(gias_sample)

# Save --------------------------------------------------------------------

saveRDS(gias_sample, "data/gias_sample.RDS")
