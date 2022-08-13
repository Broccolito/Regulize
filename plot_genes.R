library(ggplot2)
library(ggrepel)
library(ggpubr)
library(gridExtra)
library(ggplotify)
library(plotly)
library(dplyr)
library(purrr)

load("hg19_genes_annotated.rda")
load("hg38_genes_annotated.rda")

plot_gene = function(transcripts, region_start, region_end, arrow_distance = 2500, track_color = "black"){
  
  gene_symbol = transcripts$symbol[1]
  exons = filter(transcripts, role == "exon")
  
  gene_min = min(transcripts$start)
  gene_max = max(transcripts$end)
  gene_length = gene_max - gene_min
  
  text_x = (gene_min + gene_max)/2
  if(text_x < region_start){
    text_x = (gene_max + region_start)/2
  }
  if(text_x > region_end){
    text_x = (gene_min + region_end)/2
  }
  text_y = 1 + 0.5
  
  if(gene_length <= arrow_distance){
    arrows = tibble(
      start = c(gene_min, (gene_min + gene_max)/2),
      end =  c((gene_min + gene_max)/2, gene_max)
    )
  }else{
    arrows = tibble(
      start = seq(gene_min, gene_max-arrow_distance, arrow_distance),
      end = seq(gene_min+arrow_distance, gene_max, arrow_distance)
    )
  }
  
  arrow_direction = ifelse(transcripts$strand[1]=="+", "last", "first")
  
  plt = ggplot(data = transcripts, aes(y = 1)) + 
    geom_segment(data = transcripts, aes(x = start, y = 1, xend = end, yend = 1), color = track_color) + 
    geom_rect(data = exons, aes(xmin = start, xmax = end, ymin = 1 - 0.1, ymax = 1 + 0.1),
              color = track_color, fill = track_color) +
    geom_segment(data = arrows, aes(x = start, y = 1, xend = end, yend = 1), 
                 arrow = arrow(length = unit(0.15,"cm"), ends = arrow_direction, type = "open"),
                 color = track_color) + 
    geom_text_repel(d = tibble(), aes(x = text_x, y = text_y), 
                    label = gene_symbol, size = 4, fontface = "italic", color = track_color) + 
    ylab("") + 
    xlim(c(region_start, region_end)) + 
    ylim(c(0.8,1.5)) + 
    theme_void()
  
}

plot_genes = function(region_chr, region_start, region_end, track_color = "black", build = "hg19"){
  
  if(build == "hg19"){
    genes_annotated = hg19_genes_annotated
  }else if(build == "hg38"){
    genes_annotated = hg38_genes_annotated
  }else{
    cat("Please specify the correct build. Only HG19 and HG38 are currently supported...\n")
    return(NULL)
  }
  
  d = filter(genes_annotated, chr == paste0("chr", region_chr)) %>%
    filter(start >= region_start) %>%
    filter(end <= region_end) %>%
    filter(!is.na(symbol)) %>%
    filter(gene_type == "protein-coding")
  
  plt_list = tibble(genes = unique(d$symbol)) %>%
    split(.$genes)
  region_span = region_end - region_start
  
  for(gene in unique(d$symbol)){
    transcripts = filter(d, symbol == gene)
    plt = plot_gene(transcripts, 
                    region_start = region_start, 
                    region_end = region_end,
                    arrow_distance = region_span/200,
                    track_color = track_color)
    plt_list[[gene]] = plt
  }
  
  plt_list[["axis"]] = ggplot(data = d) + 
    geom_segment(data = d, aes(x = region_start, y = 1, xend = region_end, yend = 1), color = "black") + 
    theme_void()
  
  gene_plt = as.ggplot(grid.arrange(grobs = plt_list, nrow = length(plt_list)))
  
  return(gene_plt)
}

### NOT RUN
plot_genes(2, 45524546, 46513836, "#2E4057", build = "hg19")


