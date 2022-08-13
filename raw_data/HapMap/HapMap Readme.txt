###-  HapMap Linkage Disequilibrium data -###

This directory contains datafiles with linkage disequilibrium data 
compiled from merged genotype data from phases I+II+III (HapMap rel #27, NCBI B36) submitted by HapMap genotyping centers 
to the DCC. See http://ftp.hapmap.org/00README.releasenotes_rel27
for more details on this release. 
Data generated from HaploView software's .LD and .CHECK outputs for markers up to 200kb apart.

Data for the following populations are available (descriptors shown 
with three-letter and one-letter abbreviations used throughout the site):

ASW (A): African ancestry in Southwest USA
CEU (C): Utah residents with Northern and Western European ancestry from the CEPH collection
CHB (H): Han Chinese in Beijing, China
CHD (D): Chinese in Metropolitan Denver, Colorado
GIH (G): Gujarati Indians in Houston, Texas
JPT (J): Japanese in Tokyo, Japan
LWK (L): Luhya in Webuye, Kenya
MEX (M): Mexican ancestry in Los Angeles, California
MKK (K): Maasai in Kinyawa, Kenya
TSI (T): Toscans in Italy
YRI (Y): Yoruba in Ibadan, Nigeria (West Africa)

See the webpage http://www.hapmap.org/citinghapmap.html for more 
information about the populations, as well as a general discussion 
of populations and scientific strategy on http://www.hapmap.org/hapmappopulations.html. 

-File formats:
Files of each type  in all dirs have the 
same format and can be concatenated  together if desired 
and used as big table, or users can download data for just the 
chromosome they are interested in.

File formats: the current release consists of text-table files
with columns as follows:

  ld*.txt:
    Col1: Chromosomal position of marker1
    Col2: chromosomal position of marker2
    Col3: population code
    Col4: rs# for marker1
    Col5: rs# for marker2
    Col6: Dprime
    Col7: R square
    Col8: LOD
    Col9: fbin ( index based on Col1 )		    

Another way to retrieve ld data is to browse the chromosome region in the 
GBrowse viewer on the project website ( http://www.hapmap.org/cgi-perl/gbrowse)
and then use the LD Data dumper plugin to retrieve data in the same
format.


------------------------
help@hapmap.org
