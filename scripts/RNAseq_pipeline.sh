#!/bin/bash
#A step-by-step analysis pipeline for RNA-seq data from the [Cebola Lab](https://www.imperial.ac.uk/metabolism-digestion-reproduction/research/systems-medicine/genetics--genomics/regulatory-genomics-and-metabolic-disease/).
#This pipeline processes RNA-seq data for **Candida glabrata** and is designed to run on an HPC. It covers pre-alignment QC, trimming, alignment, and post-alignment processing.

## 1. Pre-alignment QC

### 1.1 FastQC on Raw Reads
#We perform quality control on the raw paired-end reads using FastQC. The raw reads are located in:
#!/bin/bash

# Define variables (converted to lowercase)
project_dir="/users/jayelazuno/argon_projects/rnaseq_analysis/cglabrata"
reads_dir="$project_dir/sample_cg30m1_lane1_20231109000"
genome_dir="/users/jayelazuno/argon_projects/rnaseq_analysis/genome_ref/cg_genref"
genome_fasta="$genome_dir/ncbi_dataset/data/gca_014217725.1/gca_014217725.1_asm1421772v1_genomic.fna"
genome_gff="$genome_dir/ncbi_dataset/data/gca_014217725.1/genomic.gff"
output= "/Users/jayelazuno/Argon_Projects/rnaseq_Analysis/output"

#Install the required programs using anaconda
#conda create -N RNA-seq

#conda install -n RNA-seq -c bioconda fastqc
#conda install -n RNA-seq -c bioconda fastp
#conda install -n RNA-seq -c bioconda multiqc
#conda install -n RNA-seq -c bioconda star
#conda install -n RNA-seq -c bioconda samtools
#conda install -n RNA-seq -c bioconda deeptools
#conda install -n RNA-seq -c bioconda salmon

# Step 2: Pre-alignment QC with FastQC
echo "Running FastQC on raw reads..."
fastqc $fastq_r1 $fastq_r2 -o $output

# Combine reports with MultiQC
echo "Running MultiQC to combine FastQC reports..."
multiqc $$output -o $output

# Step 3: Trimming using Trimmomatic
echo "Trimming paired-end reads with Trimmomatic..."
trimmomatic PE -threads 4 \
    $fastq_r1 $fastq_r2 \
    $$output/cg30m1_r1_paired.fastq.gz $$output/cg30m1_r1_unpaired.fastq.gz \
    $$output/cg30m1_r2_paired.fastq.gz $$output/cg30m1_r2_unpaired.fastq.gz \
    ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# Step 4: QC on Trimmed Reads
echo "Running FastQC on trimmed reads..."
fastqc $$output/cg30m1_r1_paired.fastq.gz $$output/cg30m1_r2_paired.fastq.gz -o $$output

# Combine MultiQC reports on trimmed reads
echo "Running MultiQC to combine FastQC reports for trimmed reads..."
multiqc $$output -o $$output

# Step 6: Index the reference genome with STAR
echo "Indexing the reference genome with STAR..."
STAR --runMode genomeGenerate \
    --genomeDir $genome_dir \
    --genomeFastaFiles $genome_fasta \
    --sjdbGTFfile $genome_gff \
    --runThreadN $star_threads

# Step 7: Align paired-end reads to reference genome using STAR and output BAM file directly
echo "Aligning trimmed reads to reference genome with STAR and outputting BAM directly..."
STAR --genomeDir $genome_dir \
    --readFilesIn $$output/cg30m1_r1_paired.fastq.gz $$output/cg30m1_r2_paired.fastq.gz \
    --readFilesCommand zcat \
    --outFileNamePrefix $$output/cg30m1_ \
    --runThreadN $star_threads \
    --outSAMtype BAM SortedByCoordinate \
    --outFilterMultimapNmax 1

# Step 8: Index the BAM file
echo "Indexing BAM file..."
samtools index $$output/cg30m1_Aligned.sortedByCoord.out.bam

# Step 9: Gene expression quantification with FeatureCounts
echo "Running FeatureCounts for gene quantification..."
featureCounts -T 4 -p -t exon -g gene_id \
  -a $genome_gff \
  -o $$output/cg30m1_counts.txt \
  $$output/cg30m1_Aligned.sortedByCoord.out.bam \
  --minMQS 10 --format DESeq2 --isPairedEnd


