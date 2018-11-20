#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(colourpicker)
library(tidyverse)
library(plotly)
attach(diamonds)


# UI (User Interface) output of fluid page function 
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  titlePanel("Diamonds app", 
             windowTitle = "Diamonds app"),
  sidebarLayout(
    sidebarPanel(sliderInput(
      "priceInput", "Select your desired price range (in US dollars).",
      min = 0, max = 18823, value = c(2000, 4000), pre="$"),
      radioButtons("cutInput", "Select the cut of the diamonds",
                   choices = c("Fair", "Good", "Very Good", "Premium", "Ideal"),
                   selected = "Good"),
      conditionalPanel(
        "diamonds",
        checkboxGroupInput("colDisplay", "Columns in diamonds table to display:",
                           names(diamonds), selected = names(diamonds))
      )),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Price Histogram with line for mean", colourInput("col", "Select colour", "blue"), plotOutput("price_hist")),
                  tabPanel("Summary of Price by Cut (with Download Option)", 
                           downloadButton('downloadBut1',"Download the summary of price by cut data"),
                           fluidRow(column(2,dataTableOutput('dto1'))),
                           DT::dataTableOutput("summary_diamonds")),
                  tabPanel("Plotly scatterplot of the sample carat vs price",  plotlyOutput("plot"),
                           verbatimTextOutput("event")),
                  tabPanel("Table of Diamonds Data (with Download Option)", 
                           downloadButton('downloadBut',"Download the diamonds data"),
                           fluidRow(column(7,dataTableOutput('dto'))),
                           DT::dataTableOutput("diamonds_data")))
    )
  )
)






# Server function is a function of input and output
# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # filter diamonds data by price and cut
  diamonds_filtered <- reactive(diamonds %>% 
                                  filter(price < input$priceInput[2],
                                         price > input$priceInput[1],
                                         cut == input$cutInput)
  )
  
  # Create summary of price by cut table
  summary_diamonds <- diamonds %>% group_by(cut) %>%  summarize(mean_price = mean(price)) %>% arrange(desc(mean_price))
  output$summary_diamonds <- DT::renderDataTable(summary_diamonds)
  output$downloadBut1 <- downloadHandler(
    filename = function(){"diamondsPriceByCutData.csv"},
    content = function(filename){
      write.csv(summary_diamonds, filename)
    }
  )
  
  # Render histogram of prices
  output$price_hist <- renderPlot({
    diamonds_filtered() %>% 
      ggplot() + geom_histogram(binwidth = 500, aes(x=price), fill = input$col) + 
      ggtitle("Price Distribution of the Diamonds")  + xlab("Price of Diamond ($)") + ylab("Frequency") +
      geom_vline(aes(xintercept = mean(price), size=2))
    
  })
  
  # Try out renderPlotly() on scatterplot of carat vs. price, coloured by carat
  output$plot <- renderPlotly({
    diamonds_filtered() %>% 
      plot_ly(x = ~carat, y = ~price, color = ~carat)
  })
  
  output$event <- renderPrint({
    hover = event_data("plotly_hover")
    if (is.null(hover)) "Please put your mouse over a point." else hover
  })
  
  # Display only the columns (variables) that are selected in the table of diamonds data
  diamonds_columns <- reactive({diamonds_filtered() %>% select(input$colDisplay)})
  
  # Download diamonds data
  output$diamonds_data <- DT::renderDataTable({diamonds_columns()})
  output$downloadBut <- downloadHandler(
    filename = function(){"diamondsData.csv"},
    content = function(filename){
      write.csv(diamonds_columns(), filename)
    }
  )
  
}


# Run the application 
shinyApp(ui = ui, server = server)


