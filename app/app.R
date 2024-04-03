library(tidyverse)
library(shiny)


ui <- fluidPage(
  titlePanel("Veiklos kodas 460000"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("pasirinkimas",
                     "Pasirinkite imone",
                     choices = NULL),
      
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  data <- readRDS("../data/sutvarkytas.rds")
data$Vidutinis.darbo.užmokestis..avgWage.=as.numeric(data$Vidutinis.darbo.užmokestis..avgWage.)
data = data %>% filter(is.na(Vidutinis.darbo.užmokestis..avgWage.)==FALSE)
names(data) = c('1', '2', 'name', '3', '4', '5', 'menuo', 'wage', '8','9','11','12')
  updateSelectizeInput(session, "pasirinkimas", choices = data$name, server = TRUE)
  
  
  output$plot <- renderPlot( data %>%
      filter(name == input$pasirinkimas) %>%
      ggplot(aes(x = ym(menuo), y = wage)) +
      geom_point() + 
      geom_line() + 
      theme_classic() + labs(x= 'metu eiga', y= 'vidutinis atlygis')
  ) 
}

shinyApp(ui = ui, server = server)
