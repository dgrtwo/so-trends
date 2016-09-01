library(shiny)
library(ggvis)

load("tag_years.rda")
tags <- unique(tag_years$Tag)

shinyUI(fluidPage(
  # Application title
  titlePanel("Stack Overflow Trends"),

  sidebarLayout(
    sidebarPanel(
      selectInput("tags",
                  label = "Tags:",
                  selected = c("r", "statistics"),
                  choices = tags,
                  multiple = TRUE),
      HTML("<p>Created by <a href='http://varianceexplained.org/'>David Robinson</a>",
           "using the <a href='http://varianceexplained.org/r/stack-lite/'>",
           "StackLite</a> dataset of Stack Overflow questions and tags.</p>",
           "<p>See <a href='https://github.com/dgrtwo/so-trends'>here</a> for the code ",
           "behind this Shiny application.")
    ),
    mainPanel(
      ggvisOutput("timePlot"),
      includeHTML("url_handler.js")
    )
  )
))
