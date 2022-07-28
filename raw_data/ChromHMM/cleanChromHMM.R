library(dplyr)

Gm12878 = read.delim("wgEncodeBroadHmmGm12878HMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "GM12878")
H1hesc = read.delim("wgEncodeBroadHmmH1hescHMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "H1-hESC")
Hepg2 = read.delim("wgEncodeBroadHmmHepg2HMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "HepG2")
Hmec = read.delim("wgEncodeBroadHmmH1hescHMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "HMEC")
Hsmm = read.delim("wgEncodeBroadHmmHsmmHMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "HSMM")
Huvec = read.delim("wgEncodeBroadHmmHuvecHMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "HUVEC")
K562 = read.delim("wgEncodeBroadHmmK562HMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "K562")
Nhek = read.delim("wgEncodeBroadHmmNhekHMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "NHEK")
Nhlf = read.delim("wgEncodeBroadHmmNhlfHMM.bed", header = FALSE) %>%
  select(V1, V2, V3, V4) %>%
  mutate(cellline = "NHLF")


hmm_data = rbind.data.frame(Gm12878, H1hesc, Hepg2,
                            Hmec, Hsmm, Huvec, K562, 
                            Nhek, Nhlf)

hmm = hmm_data %>%
  mutate(state = sapply(V4, FUN = function(x){
    unlist(strsplit(x, split = "_"))[1]
  })) %>%
  mutate(annotations = sapply(V4, FUN = function(x){
    unlist(strsplit(x, split = "_"))[2]
  })) %>%
  select(-V4)

names(hmm) = c("chr", "start", "end", "cellline", "state", "annotations")

save(hmm, file = "hmm.rda")