library(shiny)
library(stringr)
library(dplyr)
library(ggvis)
library(urltools)

load("tag_years.rda")

shinyServer(function(input, output, session) {
  observe({
    if (!is.null(input$tags) & length(input$tags) > 0) {
      tags <- paste(url_encode(input$tags), collapse = "+")
      session$sendCustomMessage(type = "setURL", list(tags = tags))
    }
  })
  
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if (!is.null(query[['tags']])) {
      tags <- str_split(query[['tags']], " ")[[1]]
      updateTextInput(session, "tags", value = tags)
    }
  })
  
  observe(
    tag_years %>%
      filter(Tag %in% input$tags) %>%
      ggvis(~Year, ~Questions / YearTotal, stroke = ~Tag) %>%
      layer_lines() %>%
      add_axis("x", format = "d") %>%
      add_axis("y", title = "% of Stack Overflow questions that year",
               format = ".2%",
               properties = axis_props(title = list(dy = -15))) %>%
      bind_shiny("timePlot", "timePlot_ui")
  )
})
