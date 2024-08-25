#!/bin/bash
conda create -N RNA-seq

conda install -n RNA-seq -c bioconda fastqc
conda install -n RNA-seq -c bioconda fastp
conda install -n RNA-seq -c bioconda multiqc
conda install -n RNA-seq -c bioconda star
conda install -n RNA-seq -c bioconda samtools
conda install -n RNA-seq -c bioconda deeptools
conda install -n RNA-seq -c bioconda salmon
#FastQC: A quality control tool for high-throughput sequence data.
#fastp: A tool designed to provide fast all-in-one preprocessing for FastQ files.
#MultiQC: A tool to aggregate results from bioinformatics analyses across many samples into a single report.
#STAR: A splice-aware RNA-seq aligner that can align reads to a reference genome.
#Samtools: A suite of programs for interacting with high-throughput sequencing data in SAM/BAM format.
#deepTools: A suite of tools for quality control, normalization, and visualization of high-throughput sequencing data.
#Salmon: A tool for quantifying the expression of transcripts from RNA-seq data.

#For differential expression using DESeq2
conda create -N DEseq2 r-essentials r-base

conda install -N DEseq2 -c bioconda bioconductor-deseq2
conda install -N DEseq2 -c bioconda bioconductor-tximport 
conda install -N DEseq2 -c r r-ggplot2

#Pre-alignment QC 
#generate FactQc reports to assess sequence quality, GC content, duplication rates, length distribution, K-mer content and adapter contamination 
fastqc <sample> .fastq.gz -d . -o . 
fastqc <sample> .fastq.gz -d . -o .
fastqc <sample> .fastq.gz -d . -o .
fastqc <sample> .fastq.gz -d . -o .

# run multiqc to combine all the fastqc out data into a summary report 
multiqc .

# extract the total number of reacds from each fastQC report 
totalreads=$(unzip -c <sample>_fastqc.zip <sample>_fastqc/fastqc_data.txt | grep 'Total Sequences' | cut -f 2)

echo $totalreads

# Trimming removes low quality reads and contaminating adapter sequences (which occur when the length of DNA sequences is longer than the DNA insert).
#Change the -l argument to change the minimum read length allowed.
fastp -i <sample>_R1.fastq.gz -I <sample>_R2.fastq.gz -o <sample>_R1.trimmed.fastq.gz -O <sample>_R2.trimmed.fastq.gz --detect_adapter_for_pe -l 25 -j <sample>.fastp.json -h <sample>.fastp.html
# For single-end reads: (note the adapter detection is not always as effective for single-end reads, so it is advisable to provide the adapter sequence, here the 'Illumina TruSeq Adapter Read 1'):
fastp -i <sample>.fastq.gz -o <sample>-trimmed.fastq.gz -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -l 25 -j <sample>.fastp.json -h <sample>.fastp.html 

# Rerun fastQC and and multiqc reports again 
fastqc <sample>_Trimmed.fastq.gz -d . -o .
fastqc <sample> .fastq.gz -d . -o .
fastqc <sample> .fastq.gz -d . -o .
fastqc <sample> .fastq.gz -d . -o .
multiqc . 

# Alignment to the reference genome
# The raw RNA-seq data in fastq format will be aligned to the reference genome, along with a reference transcriptome, to output two alignment files: the genome alignment and the transcriptome alignemnt.
#Download reference genome wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz 
# index the reference genome Set --sjdbOverhang to your maximum read length -1. The indexing also requires a file containing gene annotation, which comes in a gtf format.

GENOMEDIR=/path/to/indexed/genome
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir $GENOMEDIR --genomeFastaFiles $GENOMEDIR/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna --sjdbGTFfile gencode.v36.annotation.gtf --sjdbOverhang readlength -1 

# Perform alignment 
# STAR can then be run to align the fastq raw data to the genome. If the fastq files are in the compressed .gz format, the --readFilesCommand zcat argument is added. The output file should be unsorted, as required for the 
#downstream quantification step using Salmon. The following options are shown according to the ENCODE recommendations.

# for paired-end data
STAR --runThreadN 4 --genomeDir $GENOMEDIR --readFilesIn <sample>_R1.trimmed.fastq.gz <sample>_R2.trimmed.fastq.gz
--outFileNamePrefix <sample> --readFilesCommand zcat --outSAMtype BAM Unsorted --quantTranscriptomeBan Singleend --outFilterType BySJout 
--alignSJoverhangMin 8 --outFilterMultimapNmax 20
--alignSJDBoverhangMin 1 --outFilterMismatchNmax 999
--outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 
--alignIntronMax 1000000 --alignMatesGapMax 1000000 
--quantMode TranscriptomeSAM --outSAMattributes NH HI AS NM MD

#for single-end data 
#STAR --runThreadN 4 --genomeDir $GENOMEDIR --readFilesIn <sample>-trimmed.fastq.gz 
#--outFileNamePrefix <sample> --readFilesCommand zcat --outSAMtype BAM Unsorted --quantTranscriptomeBan Singleend --outFilterType BySJout 
#--alignSJoverhangMin 8 --outFilterMultimapNmax 20
#--alignSJDBoverhangMin 1 --outFilterMismatchNmax 999
#--outFilterMismatchNoverReadLmax 0.04 --alignIntronMin 20 
#--alignIntronMax 1000000 --alignMatesGapMax 1000000 
#--quantMode TranscriptomeSAM --outSAMattributes NH HI AS NM MD
