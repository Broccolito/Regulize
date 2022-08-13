library(dplyr)

dnase = read.delim("wgEncodeRegDnaseClusteredV3.bed", sep = "\t", header = FALSE)

names(dnase) = c("chr",	"start",	"end",	
                 "name",	"score",	"sourceCount",
                 "sourceIds",	"sourceScores")

dnase = dnase %>%
  select(chr, start, end, score, everything())

save(dnase, file = "dnase.rda")