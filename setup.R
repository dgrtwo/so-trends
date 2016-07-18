library(dplyr)
library(readr)

questions <- read_csv("~/Repositories/stacklite/questions.csv.gz")
question_tags <- read_csv("~/Repositories/stacklite/question_tags.csv.gz")

common_tags <- question_tags %>%
  group_by(Tag) %>%
  mutate(TagTotal = n()) %>%
  ungroup() %>%
  filter(TagTotal >= 1000)

library(lubridate)

question_year <- questions %>%
  filter(is.na(DeletionDate)) %>%
  transmute(Id, Year = year(CreationDate))

q_per_year <- question_year %>%
  count(Year) %>%
  rename(YearTotal = n)

tag_years <- question_year %>%
  inner_join(common_tags, by = "Id") %>%
  count(Year, Tag) %>%
  inner_join(q_per_year, by = "Year") %>%
  rename(Questions = n)

save(tag_years, file = "tag_years.rda")