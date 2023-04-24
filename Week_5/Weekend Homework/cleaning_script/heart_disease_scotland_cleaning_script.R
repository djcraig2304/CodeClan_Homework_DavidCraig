library(tidyverse)
library(janitor)
library(shiny)

heart_disease_data_scotland <- read_csv("raw_data/cvd_mortality_scotland.csv")



heart_disease_scotland_clean <- heart_disease_data_scotland %>%
  clean_names() %>%
  select(-crude_rate_qf, -number_of_deaths_qf, -sex_qf, -age_group_qf,
         -hbrqf) %>%
  mutate(hbr = ifelse(hbr == "S08000015", "Ayrshire and Arran", hbr),
         hbr = ifelse(hbr == "S08000016", "Borders", hbr),
         hbr = ifelse(hbr == "S08000017", "Dumfries and Galloway", hbr),
         hbr = ifelse(hbr == "S08000018", "Fife", hbr),
         hbr = ifelse(hbr == "S08000019", "Forth Valley", hbr),
         hbr = ifelse(hbr == "S08000020", "Grampian", hbr),
         hbr = ifelse(hbr == "S08000021", "Greater Glasgow and Clyde", hbr),
         hbr = ifelse(hbr == "S08000022", "Highland", hbr),
         hbr = ifelse(hbr == "S08000023", "Lanarkshire", hbr),
         hbr = ifelse(hbr == "S08000024", "Lothian", hbr),
         hbr = ifelse(hbr == "S08000025", "Orkney", hbr),
         hbr = ifelse(hbr == "S08000026", "Shetland", hbr),
         hbr = ifelse(hbr == "S08000027", "Tayside", hbr),
         hbr = ifelse(hbr == "S08000028", "Western Isles", hbr),
         hbr = ifelse(hbr == "S08000029", "Fife", hbr),
         hbr = ifelse(hbr == "S08000030", "Tayside", hbr),
         hbr = ifelse(hbr == "S08000031", "Greater Glasgow and Clyde", hbr),
         hbr = ifelse(hbr == "S08000032", "Lanarkshire", hbr),
         hbr = ifelse(hbr == "S92000003", "All of Scotland", hbr)
  ) %>%
  rename(age_group_years = age_group,
         nhs_health_board = hbr) %>%
  mutate(age_group_years = str_remove(age_group_years, " years"),
         sex = str_remove(sex, "[s]"))

write_csv(heart_disease_scotland_clean, "clean_data/clean_heart_disease_scotland.csv")

