require(tidyverse)

files = list.files("1_data/literature_search",full.names = T)

data_list = lapply(files, readxl::read_excel)

data = data_list %>% do.call(what = rbind) %>% 
  filter(!is.na(Abstract), 
         Language == "English", 
         !duplicated(Abstract)) %>% 
  mutate(id = 1:n()) %>% 
  select(id, everything())

write_csv(data, "1_data/data.csv")


