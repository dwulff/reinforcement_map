require(tidyverse)
require(xml2)
require(rvest)

# EXCEL DATA --------

files = list.files("1_data/literature_search",full.names = T)

data_list = lapply(files, readxl::read_excel)

data = data_list %>% do.call(what = rbind)


# # RIS DATA --------
# 
# read_ris = function(file){ 
#   lines = read_lines(file)
#   
#   paper_list = split(lines, cumsum(lines == ""))
#   paper_list = paper_list[lengths(paper_list) != 1]
#   print(length(paper_list))
#   tbl_list = list()
#   for(i in 1:length(paper_list)){
#     
#     # if(i %% 100 == 0) print(i)
#     paper = paper_list[[i]]
#     paper = paper[paper != ""]
#     vars = str_sub(paper, 1, 2)
#     var_list = split(paper, vars)[unique(vars)]
#     content = sapply(var_list, function(x){
#       x = str_remove(x, "[A-Z]{2}[:blank:]+-[:blank:]")
#       paste(x, collapse="@@@")
#     })
#     
#     matrix(content, ncol = length(unique(vars)), 
#            dimnames = list(NULL, unique(vars))) %>% 
#       as_tibble() -> tbl_list[[i]]
#     
#   }
#   
#   data = tbl_list %>% do.call(what = bind_rows)
# }
# 
# files = list.files("1_data/literature_search_ris/", full.names = T)
# 
# data_ris = lapply(files, read_ris) %>% 
#   do.call(what = bind_rows)

# TEXT DATA --------

files = list.files("1_data/literature_search_text/",full.names = T)

a = read_lines(files[1])
b = str_split(a, "\t")

data_list = lapply(files, function(x) {
  
  read_lines(x) %>% str_split("\t") %>% 
    `[`(-1) %>% 
    do.call(what = rbind)

  }) 

data_tsv = do.call(rbind, data_list) 
colnames(data_tsv) = read_lines(files[1]) %>% `[`(1) %>% str_split("\t") %>% `[[`(1)

data_tsv = data_tsv %>% 
  as_tibble() %>% 
  readr::type_convert()

names(data_tsv) = names(data)[-ncol(data)]


# JOIN DATA --------

data = data_tsv %>% 
  filter(!is.na(Abstract), 
         Language == "English", 
         !duplicated(Abstract)) %>% 
  mutate(id = 1:n()) %>% 
  select(id, everything())

write_csv(data, "1_data/data.csv")

