require(tm)

# tokenize abstracts
abstracts_tokens <- tm::Boost_tokenizer(data$Abstract_cleaned)

# count unique tokens
abstracts_tokens <- abstracts_tokens %>%
  as_tibble() %>%
  group_by(value) %>%
  summarize(n = n()) 


# how many tokens have a number or a digit in it?
mean(str_detect(abstracts_tokens$value, "[:punct:]|[:digit:]"))


# read wikipedia data
wiki <- read_delim("1_data/wiki_word_frequency/enwiki-2023-04-13.txt", col_names = c("token", "n_wiki"))

# combine abstract data with wikipedia data. only words that occur at least once in each data set will be considered
df <- abstracts_tokens %>%
  inner_join(wiki, by=join_by(value==token)) %>%
  rename(n_abstracts = n) %>%
  mutate(logp_abstracts = log(n_abstracts/sum(n_abstracts)),
         logp_wiki = log(n_wiki/sum(n_wiki)),
         logp_diff = logp_abstracts - logp_wiki)


# sort by logp_diff descending 
df %>% arrange(-logp_diff) %>% print(n = 20)
