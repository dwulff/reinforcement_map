require(tidyverse)

data = read_csv("1_data/data.csv")

author_split = str_split(data$Authors, ";")
paper_author_net = matrix(NA, 
                          ncol = length(author_split), 
                          nrow = length(author_split))

for(i in 1:(length(author_split)-1)){
  print(i)
  for(j in (i+1):length(author_split)){
  inter = length(intersect(author_split[[i]], author_split[[j]]))
  if(inter == 0) next
  union = length(union(author_split[[i]], author_split[[j]]))
  paper_author_net[i, j] = paper_author_net[j, i] = inter / union
  }
}
paper_author_net[is.na(paper_author_net)] = 0

saveRDS(paper_author_net, "1_data/nets/author_net.RDS")


