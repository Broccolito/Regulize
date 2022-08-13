library(dplyr)
library(ggplot2)
library(ggpubr)
library(org.Hs.eg.db)

process_gtf = function(file_loc = "hg19.ensGene.gtf"){
  
  genes = read.delim(gzfile(file_loc), sep = "\t", header = FALSE)
  
  gene_id = strsplit(genes$V9, split = "; ") %>%
    lapply(function(x){x[1]}) %>%
    unlist() %>%
    gsub(pattern = "gene_id ", replacement = "")
  
  transcript_id = strsplit(genes$V9, split = "; ") %>%
    lapply(function(x){x[2]}) %>%
    unlist() %>%
    gsub(pattern = "transcript_id ", replacement = "")
  
  exon_number = strsplit(genes$V9, split = "; ") %>%
    lapply(function(x){x[3]}) %>%
    unlist() %>%
    gsub(pattern = "exon_number ", replacement = "") %>%
    as.numeric()
  
  genes = dplyr::select(genes, V1, V3, V4, V5, V7)
  names(genes) = c("chr", "role", "start", "end", "strand")
  genes[["gene_id"]] = gene_id
  genes[["transcript_id"]] = transcript_id
  genes[["exon_number"]] = exon_number
  
  ens2ref = AnnotationDbi::select(org.Hs.eg.db, columns = c("ENSEMBL", "SYMBOL", "GENENAME", "GENETYPE"),
                   keys = unique(genes$gene_id), keytype = "ENSEMBL")
  
  genes_annotated = genes %>%
    mutate(ENSEMBL = gene_id) %>%
    left_join(ens2ref, by = "ENSEMBL") %>%
    dplyr::select(-ENSEMBL)
  
  names(genes_annotated)[9] = "symbol"
  names(genes_annotated)[10] = "gene_name"
  names(genes_annotated)[11] = "gene_type"
  
  return(genes_annotated)
  
}

hg19_genes_annotated = process_gtf("hg19.ensGene.gtf.gz")
hg38_genes_annotated = process_gtf("hg38.ensGene.gtf.gz")

save(hg19_genes_annotated, file = "hg19_genes_annotated.rda")
save(hg38_genes_annotated, file = "hg38_genes_annotated.rda")
