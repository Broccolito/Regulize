library(dplyr)

### RS id needed
# chromosome = 5
# position = 40798644
population = "MEX"
ld_query = paste0("ftp.ncbi.nlm.nih.gov/hapmap/ld_data/2009-04_rel27/ld_chr", 
                  chromosome, "_", population, ".txt.gz")

temp_directory = tempdir()
ld_file_path = file.path(temp_directory, "ld.txt.gz")
download.file(url = ld_query, destfile = ld_file_path)
ld = read.delim(ld_file_path, sep = " ", header = FALSE)
names(ld) = c("pos1", "pos2", "pop", "rs1", "rs2", "dprime", "r2", "log_odds", "fbin")

filter(ld, rs1 == 'rs10035235')
