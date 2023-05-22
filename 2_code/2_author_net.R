require(tidyverse)

data = read_csv("1_data/data.csv")

author_split = str_split(data$Authors, ";")
paper_author_net = matrix(0, 
                          ncol = length(author_split), 
                          nrow = length(author_split))

for(i in 1:(length(author_split)-1)){
  print(i)
  for(j in (i+1):length(author_split)){
    
  inter = length(intersect(author_split[[i]], author_split[[j]]))
  union = length(union(author_split[[i]], author_split[[j]]))
  paper_author_net[i, j] = paper_author_net[j, i] = inter / union
  
  }
}

paper_author_net[is.na(paper_author_net)] = 0
g = igraph::graph_from_adjacency_matrix(paper_author_net, 
                                    mode = "undirected", weighted = TRUE)

clusters = igraph::cluster_louvain(g)

table(clusters$membership) %>% sort(decreasing = T) %>% `[`(1:20)

author_split[clusters$membership == 2] %>% unlist() %>% 
  table() %>% sort(decreasing = T) %>% `[`(1:20)

data %>% mutate(authorship_cluster = clusters$membership) %>% 
  filter(str_detect(Authors, "Spektor")) %>% 
  select(Authors, authorship_cluster) %>% 
  print(n  = 25)






