# this script compares the frequency of words in the abstracts against English wikipedia

require(tidyverse)
library(tidytext)

data <- read.csv("1_data/data_cleaned.csv")


# tokenize abstracts
abstracts_df <- tibble(abstract=1:nrow(data), text=data$Abstract_cleaned)

abstracts_tokenized <- abstracts_df %>% unnest_tokens(word, text)

# count unique tokens
abstracts_tokens <- abstracts_tokenized %>%
  as_tibble() %>%
  group_by(word) %>%
  summarize(n = n()) 


# how many tokens have a number or a digit in it?
mean(str_detect(abstracts_tokens$word, "[:punct:]|[:digit:]"))


# read wikipedia data
wiki <- read_delim("1_data/wiki_word_frequency/enwiki-2023-04-13.txt", col_names = c("word", "n_wiki"))

# combine abstract data with wikipedia data. only words that occur at least once in each data set will be considered
tokens <- abstracts_tokens %>%
  inner_join(wiki, by=join_by(word)) %>%
  rename(n_abstracts = n) %>%
  mutate(logp_abstracts = log(n_abstracts/sum(n_abstracts)),
         logp_wiki = log(n_wiki/sum(n_wiki)),
         logp_diff = logp_abstracts - logp_wiki)


# sort by logp_diff descending 
tokens %>% dplyr::arrange(-logp_diff) %>% print(n = 20)
