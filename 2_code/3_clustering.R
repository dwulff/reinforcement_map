
g = igraph::graph_from_adjacency_matrix(paper_author_net, 
                                        mode = "undirected", 
                                        weighted = TRUE)

set.seed(6)
clusters = igraph::cluster_louvain(g)

# inspect

table(clusters$membership) %>% sort(decreasing = T) %>% `[`(1:20)

author_split[clusters$membership == 2] %>% unlist() %>% 
  table() %>% sort(decreasing = T) %>% `[`(1:20)

data %>% mutate(authorship_cluster = clusters$membership) %>% 
  filter(str_detect(Authors, "Spektor")) %>% 
  select(Authors, authorship_cluster) %>% 
  print(n  = 25)


top_20 = table(clusters$membership) %>% sort(decreasing = T) %>% `[`(1:20)

res = sapply(names(top_20), function(x) {
  n = sum(clusters$membership == as.numeric(x))
  sub_authors = author_split[clusters$membership == as.numeric(x)] %>% 
    unlist() %>% 
    table() %>% 
    sort(decreasing = T) %>% 
    names() %>% 
    `[`(1:6) %>%
    str_trim() %>% 
    str_extract("^[:alpha:]+[^,]")
  c(n, sub_authors[1], paste(sub_authors[-1], collapse=", "))
}) %>% t()
colnames(res) = c("N", "Author", "Coauthors")
res = as_tibble(res) %>% readr::type_convert()

par(mar=c(3,5,1,1))
plot.new();plot.window(xlim=c(0, 210), ylim=c(.5, 20.5))

ypos = 20:1
w = .45
cols = viridis::cividis(20, end = .9)
rect(0,ypos - w,res$N,ypos+w, border=NA, col = cols)

mtext(res$Author, at = ypos, 
      side=2, las=1, line = -.5)
text(3, ypos, labels = res$Coauthors, 
     cex=.5, col = "white", adj = 0)
mtext("Number of publications in cluster", 
      side=1, line=1)
mtext(seq(0, 200, 20), at = seq(0, 200, 20), 
      side=1, cex=.8, line = -.5)
