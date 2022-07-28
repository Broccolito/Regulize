library(dplyr)

cpg = read.delim("cpgIslandExt.txt", sep = "\t", header = FALSE)

names(cpg) = c("bin",	"chr",	"start",	"end",
               "name",	"length",	"cpgNum",	"gcNum",
               "perCpg",	"perGc",	"obsExp")

cpg = cpg %>%
  select(chr, start, end, everything())

save(cpg, file = "cpg.rda")