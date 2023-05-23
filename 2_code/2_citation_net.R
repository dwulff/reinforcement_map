require(tidyverse)

data = read_csv("1_data/data.csv")

references_split = str_split(data$`Cited References`, ";")
references_split = lapply(references_split, function(x) str_trim(x))
paper_citation_net = matrix(NA, 
                          ncol = length(references_split), 
                          nrow = length(references_split))

for(i in 1:(length(references_split)-1)){
  print(i)
  for(j in (i+1):length(references_split)){
    inter = length(intersect(references_split[[i]], references_split[[j]]))
    if(inter == 0) next
    union = length(union(references_split[[i]], references_split[[j]]))
    paper_citation_net[i, j] = paper_citation_net[j, i] = inter / union
  }
}
paper_citation_net[is.na(paper_citation_net)] = 0

saveRDS(paper_citation_net, "1_data/nets/citation_net.RDS")

