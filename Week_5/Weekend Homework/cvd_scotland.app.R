library(shiny)
library(tidyverse)

heart_disease_scotland <- read_csv("clean_data/clean_heart_disease_scotland.csv")

year_groups <- heart_disease_scotland %>% 
  distinct(year) %>% 
  pull()

age_groups <- heart_disease_scotland %>% 
  distinct(age_group_years) %>% 
  pull()
  

  
ui <- fluidPage(
  titlePanel(title = "Cardiovascular Disease (CVD) in Scotland"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "sex_input",
        label = "Sex:",
        choices = c("Male", "Female"),
        inline = TRUE),
      
      selectInput(
        inputId = "year_input",
        label = "Year",
        choices = year_groups
      ),
      
      selectInput(
        inputId = "age_input",
        label = "Age Groups",
        choices = age_groups)
    ),
  
    mainPanel(
      plotOutput("crude_rate_graph")
  )
 )
)


server <- function(input, output, session) {
  #this code creates a graph which visualizes the mortality rate from CVD in Scotland for males and females as a bar chart.
  # this visualization is useful for epidemiologists to see CVD in Scotland for different age groups and sexes over 10 years.
  output$crude_rate_graph <- renderPlot({
      heart_disease_scotland_clean %>% 
      filter(year %in% input$year_input,
             age_group_years %in% input$age_input,
             sex %in% input$sex_input) %>%
      ggplot() +
      aes(x = nhs_health_board, y = number_of_deaths, fill = diagnosis) +
      geom_col(colour = "black") +
      coord_flip() +
      labs(x = "NHS Health Board", 
           y =  "Number of Deaths",
           title = "CVD Mortality Scotland",
           subtitle = "by NHS Health Board (2012-2021)",
           legend) +
      theme(plot.title.position = "plot",
            plot.title = element_text(size = 20),
            plot.subtitle = element_text(size = 16),
            axis.title = element_text(size = 12),
            axis.text = element_text(size =12),
            legend.title = element_text(size =12)) 
    
  })
   
  
}

shinyApp(ui = ui, server = server)