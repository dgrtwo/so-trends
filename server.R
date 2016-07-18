library(shiny)
library(dplyr)
library(ggvis)

load("tag_years.rda")

shinyServer(function(input, output) {
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
