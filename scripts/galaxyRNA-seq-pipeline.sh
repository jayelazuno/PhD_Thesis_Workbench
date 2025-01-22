#!/bin/bash
#############
#author: Joshua Ayelazuno
# This a RNA seq pipeline reproduced by on the command line by following a tutorial provide by galaxy
# The tutorial can be accessed https://training.galaxyproject.org/training-material/topics/transcriptomics/tutorials/ref-based/tutorial.html
# Generally, the reason we analyse RNA-seq data and other forms of seq data are:
# What are the steps to process RNA-Seq data?

#How to identify differentially expressed genes across multiple experimental conditions?

#What are the biological functions impacted by the differential expression of genes?
#DNA sequences are stored in fastQ files, the second line of every 4 lines 
# FastQ stores sequence and qaulity info
#A FASTQ file has four line-separated fields per sequence:

#Field 1 begins with a '@' character and is followed by a sequence identifier and an optional description (like a FASTA title line).
#Field 2 is the raw sequence letters.
#Field 3 begins with a '+' character and is optionally followed by the same sequence identifier (and any description) again.
#Field 4 encodes the quality values for the sequence in Field 2, and must contain the same number of symbols as letters in the sequence.
#A FASTQ file containing a single sequence might look like this:

#@SEQ_ID
#GATTTGGGGTTCAAAGCAGTATCGATCAAATAGTAAATCCATTTGTTCAACTCACAGTTT
#+
#!''*((((***+))%%%++)(%%%%).1***-+*''))**55CCF>>>>>>CCCCCCC65

# Quality control

# Quality control
#During sequencing, errors are introduced, such as incorrect nucleotides being called. These are due to the technical
# limitations of each sequencing platform. Sequencing errors might bias the analysis and can lead to a misinterpretation of the data.
# Adapters may also be present if the reads are longer than the fragments sequenced and trimming these may improve the number of reads mapped.

#Sequence quality control is therefore an essential first step in your analysis. We will use similar tools as described in the “Quality control” tutorial: FastQC to 
#create a report of sequence quality, MultiQC (Ewels et al. 2016) to aggregate generated reports and 
#Cutadapt (Marcel 2011) to improve the quality of sequences via trimming and filtering.
# thinks to check after Running FastQC and MultiQC 
#1. Sequence Counts Sequence counts for each sample. Duplicate read counts are an estimate only
#2. Sequence Quality Histograms 
#3.The mean quality value across each base position in the read.
#4.The number of reads with average quality scores. Shows if a subset of reads has poor quality.
#5.Per Sequence GC Content The average GC content of reads. Normal random library typically have a roughly normal distribution of GC content.
#6Per Base N Content. The percentage of base calls at each position for which an N was called, should be low
#7 Sequence Duplication Levels. The relative level of duplication found for every sequence.Duplicated sequences: >10 to >500
#8 Overrepresented sequences by sample.The total amount of overrepresented sequences found in each library.
#9 Adapter Content The cumulative percentage count of the proportion of your library which has seen each of the adapter sequences at each position.

#If the quality of the reads is poor, we should:

#1.Check what is wrong and think about possible reasons for the poor read quality: it may come from the type of sequencing or what we sequenced (high quantity of overrepresented sequences in transcriptomics data, biased percentage of bases in Hi-C data)
#2.Ask the sequencing facility about it
#3. Perform some quality treatment (taking care not to lose too much information) with some trimming or removal of bad reads

# Singel and end and paired-end sequencing.

#The paired-end sequencing is based on the idea that the initial DNA fragments (longer than the actual read length) is sequenced from both sides. This approach results in two reads per fragment, with the first read in forward orientation and the second read in reverse-complement orientation. The distance between both reads is known. Thus, it can be used as an additional piece of information to improve the read mapping.

#With paired-end sequencing, each fragment is more covered than with single-end sequencing (only forward orientation sequenced):

#The paired-end sequencing generates then 2 files:

#1. One file with the sequences corresponding to forward orientation of all the fragments
#2. One file with the sequences corresponding to reverse orientation of all the fragments

# Cutadapt to trim FASTQS
# Why do we run the trimming tool only once on a paired-end dataset and not twice, once for each dataset?
#The tool can remove sequences if they become too short during the trimming process. For paired-end files 
#it removes entire sequence pairs if one (or both) of the two reads became shorter than the set length 
#cutoff. Reads of a read-pair that are longer than a given threshold but for which the partner read has 
#become too short can optionally be written out to single-end files. This ensures that the information of a read pair is not lost entirely if only one read is of good quality.

# MAPPING 
#To make sense of the reads, we need to first figure out where the sequences originated from in the genome, so we can then determine to which genes they belong.
#When a reference genome for the organism is available, this process is known as aligning or “mapping” the reads to the reference.
# This is equivalent to solving a jigsaw puzzle, but unfortunately, not all pieces are unique.
#A reference genome (or reference assembly) is a set of nucleic acid sequences assembled as a representative example of a species’ genetic material. 
#As they are often assembled from the sequencing of different individuals, they do not accurately represent the set of genes of any single organism, but a mosaic of different nucleic acid sequences from each individual.
#As the cost of DNA sequencing falls, and new full genome sequencing technologies emerge, more genome sequences continue to be generated. 
#Using these new sequences, new alignments are built and the reference genomes improved (fewer gaps, 
#fixed misrepresentations in the sequence, etc). The different reference genomes correspond to the different released versions (called “builds”).

# mapped with percentages below 70% should be investigated for potential contamination. 
#Both samples have a low (less than 10%) percentage of reads that mapped to multiple locations on the reference genome.
# This is in the normal range for Illumina short-read sequencing, but may be lower for newer long-read sequencing datasets that can span larger repeated regions in the reference genome and will be higher for 3’ end libraries.

#The main output of STAR is a BAM file.

#A BAM (Binary Alignment Map) file is a compressed binary file storing the read sequences, whether they have been aligned to a reference sequence (e.g. a chromosome), and if so, the position on the reference sequence at which they have been aligned.
#A BAM file (or a SAM file, the non-compressed version) consists of:

#A header section (the lines starting with @) containing metadata particularly the chromosome names and lengths (lines starting with the @SQ symbol)
#An alignment section consisting of a table with 11 mandatory fields, as well as a variable number of optional fields:

#Inspection of the mapping results
#The BAM file contains information for all our reads, making it difficult to inspect and explore in text format.
 #A powerful tool to visualize the content of BAM files is the Integrative Genomics Viewer (IGV, Robinson et al. 2011).

 #What information appears at the top as grey peaks?The coverage plot: the sum of mapped reads at each position
#What do the connecting lines between some of the aligned reads indicate?They indicate junction events (or splice sites), i.e. reads that are mapped across an intron

#IGV tool: Inspect the splice junctions using a Sashimi plot
#What does the vertical red bar graph represent? What about the arcs with numbers? The coverage for each alignment track is plotted as a red bar graph. Arcs represent observed splice junctions, i.e., reads spanning introns.
#What do the numbers on the arcs mean? The numbers refer to the number of observed junction reads.
#Why do we observe different stacked groups of blue linked boxes at the bottom? The different groups of linked boxes on the bottom represent the different transcripts from the genes at this location which are present in the GTF file.


# Counting the number of reads per annotated gene
#To compare the expression of single genes between different conditions (e.g. with or without PS depletion), 
#an essential first step is to quantify the number of reads per gene, or more specifically the number of reads mapping to the exons of each gene.
#Two main tools are available for read counting: HTSeq-count (Anders et al. 2015) or featureCounts (Liao et al. 2013). 
#Additionally, STAR allows to count reads while mapping: its results are identical to those from HTSeq-count. 
#While this output is sufficient for most analyses, featureCounts offers more customization on how to count reads (minimum mapping quality, counting reads instead of fragments, count transcripts instead of genes etc.).
# Details: Further check for the quality of the data
# The quality of the data and mapping can be checked further, e.g. by inspecting read duplication level, number of reads mapped to each chromosome, gene body coverage, and read distribution across features.
#Duplicate reads can come from highly-expressed genes, therefore they are usually kept in RNA-Seq differential expression analysis.
# But a high percentage of duplicates may indicate an issue, e.g. over amplification during PCR of low complexity library.

#MarkDuplicates from Picard suite examines aligned records from a BAM file to locate duplicate reads, i.e. reads mapping to the same location (based on the start position of the mapping).
#In general, obtaining up to 50% duplicated reads is considered normal. 

#Number of reads mapped to each chromosome
#To assess the sample quality (e.g. excess of mitochondrial contamination), we can check the sex of samples, or to see if any chromosomes have highly expressed genes, 
#we can check the numbers of reads mapped to each chromosome using IdxStats from the Samtools suite.

#Gene body coverage
#The different regions of a gene make up the gene body. It is important to check if read coverage is uniform across the gene body. 
#For example, a bias towards the 5’ end of genes could indicate degradation of the RNA. Alternatively, a 3’ bias could indicate that the data is from a 3’ assay. 
#To assess this, we can use the Gene Body Coverage tool from the RSeQC (Wang et al. 2012) tool suite. This tool scales all transcripts to 100 nucleotides (using a provided annotation file) 
#and calculates the number of reads covering each (scaled) nucleotide position. As this tool is really slow, we will compute the coverage only on 200,000 random reads.

#Read distribution across features
#With RNA-Seq data, we expect most reads to map to exons rather than introns or intergenic regions. Before going further in counting and differential expression analysis, it may be interesting to check the distribution of reads across known gene features (exons, CDS, 5’ UTR, 3’ UTR, introns, intergenic regions). For example, a high number of reads mapping to intergenic regions may indicate the presence of DNA contamination.

# Here we will use the Read Distribution tool from the RSeQC (Wang et al. 2012) tool suite, which uses the annotation file to identify the position of the different gene features.
#
#After the mapping, we now have the information on where the reads are located on the reference genome and how well they were mapped. 
#The next step in RNA-Seq data analysis is quantification of the number of reads mapped to genomic features (genes, transcripts, exons, …).
#The quantification depends on both the reference genome (the FASTA file) and its associated annotations (the GTF file).
 #It is extremely important to use an annotation file that corresponds to the same version of the reference genome you used for the mapping (e.g. dm6 here),
  #as the chromosomal coordinates of genes are usually different amongst different reference genome versions.

  #Counting the number of reads per annotated gene
  #To compare the expression of single genes between different conditions (e.g. with or without PS depletion), 
  #an essential first step is to quantify the number of reads per gene, or more specifically the number of reads mapping to the exons of each gene.

#Two main tools are available for read counting: HTSeq-count (Anders et al. 2015) or featureCounts (Liao et al. 2013). 
#Additionally, STAR allows to count reads while mapping: its results are identical to those from HTSeq-count. 
#While this output is sufficient for most analyses, featureCounts offers more customization on how to count reads (minimum mapping quality, counting reads instead of fragments, count transcripts instead of genes etc.).

#In principle, the counting of reads overlapping with genomic features is a fairly simple task. But the strandness of the library needs to be determined. 
#Indeed this is a parameter of featureCounts. On the contrary, STAR evaluates the counts into the three possible strandnesses but you still need this information to extract the counts which corresponds to your library.

#Estimation of the strandness
#RNAs that are typically targeted in RNA-Seq experiments are single stranded (e.g., mRNAs) and thus have polarity (5’ and 3’ ends that are functionally distinct). 
#During a typical RNA-Seq experiment the information about strandness is lost after both strands of cDNA are synthesized, size selected, and converted into a sequencing library. 
#However, this information can be quite useful for the read counting step, especially for reads located on the overlap of 2 genes that are on different strands.

#Some library preparation protocols create so-called stranded RNA-Seq libraries that preserve the strand information (Levin et al. 2010 provides an excellent overview). 
#In practice, with Illumina RNA-Seq protocols you are unlikely to encounter all of the possibilities described in this article. You will most likely deal with either:

#1. Unstranded RNA-Seq data
#2 Stranded RNA-Seq data generated by the use of specialized RNA isolation kits during sample preparation#

#The implication of stranded RNA-Seq is that you can distinguish whether the reads are derived from forward or reverse-encoded transcripts.
#In a stranded forward library, reads map mostly on the same strand as the genes. With stranded reverse library, reads map mostly on the opposite strand. 
#With unstranded library, reads map on genes on both strands independently of the orientation of the gene (Example for single-end read library).

#There are 4 ways to estimate strandness from STAR results (choose the one you prefer)

#We can do a visual inspection of read strands on IGV (for Paired-end dataset it is less easy than with single read and when you have a lot of samples, this can be painful).

#1. Alternatively, instead of using the BAM you can use the stranded coverage generated by STAR. 
#2. Using pyGenomeTracks we will be able to visualize the coverage on each strand for each sample. This tool has a lot of parameters to customize your plots.
#3. You can use the output of STAR with the counts. Indeed as explained before, STAR evaluates the number of reads on genes for the three possible scenarios: unstranded library, stranded forward or stranded reverse. 
#The condition which attributes more reads to gene must be the condition which matches your library.
    # About 75% of reads are asigned to genes if the library is unstranded, while it is around 40% in the other case
    # This suggests that the library is unstranded.

#4. Another option is to estimate these parameters with a tool called Infer Experiment from the RSeQC (Wang et al. 2012) tool suite
    # This tool takes the BAM files from the mapping, selects a subsample of the reads and compares their genome coordinates and strands with those of the reference gene model (from an annotation file).
    # Based on the strand of the genes, it can gauge whether sequencing is strand-specific, and if so, how reads are stranded (forward or reverse).
    #Paired-end or single-end library
#Fraction of reads failed to determine
#2 lines
    #For single-end
        #Fraction of reads explained by "++,--": the fraction of reads that assigned to forward strand
        #Fraction of reads explained by "+-,-+": the fraction of reads that assigned to reverse strand
    #For paired-end
        #Fraction of reads explained by "1++,1--,2+-,2-+": the fraction of reads that assigned to forward strand
        #Fraction of reads explained by "1+-,1-+,2++,2--": the fraction of reads that assigned to reverse strand
#If the two “Fraction of reads explained by” numbers are close to each other, we conclude that the library is not a strand-specific dataset (or unstranded).


# Hands-on: Counting the number of reads per annotated gene
# Feature counts 
#If the percentage is below 50%, you should investigate where your reads are mapping (inside genes or not, with IGV) and check that the annotation corresponds to the correct reference genome version.
#The main output of featureCounts is a table with the counts, i.e. the number of reads (or fragments in the case of paired-end reads) mapped to each gene (in rows, with their ID in the first column) in the provided annotation. 
#FeatureCount generates also the feature length output datasets. We will need this file later on when we will run the goseq tool.

#Analysis of the differential gene expression
# Identification of the differentially expressed features
        #The number of sequenced reads mapped to a gene therefore depends on:

        #The sequencing depth of the samples

        #Samples sequenced with more depth will have more reads mapping to each genes

        #The length of the gene

        #Longer genes will have more reads mapping to them

        #To compare samples or gene expressions, the gene counts need to be normalized. We could use TPM (Transcripts Per Kilobase Million).
    
    #RNA-Seq is often used to compare one tissue type to another, for example, muscle vs. 
    #epithelial tissue. And it could be that there are a lot of muscle specific genes transcribed in muscle but not in the epithelial tissue. We call this a difference in library composition.

    #It is also possible to see a difference in library composition in the same tissue type after the knock out of a transcription factor.

    #Let’s imagine we have RNA-Seq counts from 2 samples (same library size: 635 reads), for a genome with 6 genes. 
    #he genes have the same expression in both samples, except one: only Sample 1 transcribes gene D, at a high level (563 reads).
    # As the library size is the same for both samples, sample 2 has 563 extra reads to be distributed over genes A, B, C, E and F.

        #As a result, the read count for all genes except for genes C and D is really high in Sample 2. Nonetheless, the only differentially expressed gene is gene D.

        #TPM, RPKM or FPKM do not deal with these differences in library composition during normalization, but more complex tools, like DESeq2, do.
            #DESeq2 (Love et al. 2014) is a great tool for dealing with RNA-seq data and running Differential Gene Expression (DGE) analysis. 
            #It takes read count files from different samples, combines them into a big table (with genes in the rows and samples in the columns) and applies normalization for sequencing depth and library composition.
            #We do not need to account for gene length normalization does because we are comparing the counts between sample groups for the same gene.
            
                    # The goal is to calculate a scaling factor for each sample, which takes read depth and library composition into account.

                    #1. Take the log_e of all the values
                    #2. Average each row: he average of the log values (also known as the geometric average) is used here because it is not easily impacted by outlier
                    #3. Filter out genes with which have infinity as a value.Here we filter out genes with no read counts in at least 1 sample, e.g. genes only transcribed in one tissue  
                    #This helps to focus the scaling factors on genes transcribed at similar levels, regardless of the condition.
                    #4. Subtract the average log value from the log counts: log(counts for gene X)−average(log values for counts for gene X)=log(counts for gene X/average for gene X)
                        #This step compares the ratio of the counts in each sample to the average across all samples.
                    #5Calculate the median of the ratios for each sample: The median is used here to avoid extreme genes (most likely rare ones) from swaying the value too much in one direction. 
                        #It helps to put more emphasis on moderately expressed genes.
                    #6 Compute the scaling factor by taking the exponential of the medians:(x^-e)
                    #7. Compute the normalized counts: divide the original counts by the scaling factors
#DESeq2 also runs the Differential Gene Expression (DGE) analysis, which has two basic tasks:

    #Estimate the biological variance using the replicates for each condition
   #Estimate the significance of expression differences between any two conditions
            #This expression analysis is estimated from read counts and attempts are made to correct for variability in measurements using replicates, that are absolutely essential for accurate results.
            # For your own analysis, we advise you to use at least 3, but preferably 5 biological replicates per condition. It is possible to have different numbers of replicates per condition.
            #Multiple factors with several levels can then be incorporated in the analysis describing known sources of variation (e.g. treatment, tissue type, gender, batches), with two or more levels representing the conditions for each factor. After normalization we can compare the response of the expression of any gene to the presence of different levels of a factor in a statistically reliable way.

            #In our example, we have samples with two varying factors that can contribute to differences in gene expression:

            #1. Treatment (either treated or untreated)
            #2. Sequencing type (paired-end or single-end)
            #Here, treatment is the primary factor that we are interested in. The sequencing type is further information we know about the data that might affect the analysis. 
            #Multi-factor analysis allows us to assess the effect of the treatment, while taking the sequencing type into account too.

            #Comment
            #We recommend that you add all factors you think may affect gene expression in your experiment. It can be the sequencing type like here, but it can also be the manipulation (if different persons are involved in the library preparation), other batch effects, etc…

            #If you have only one or two factors with few number of biological replicates, the basic setup of DESeq2 is enough. In the case of a complex experimental setup with a large number of biological replicates, tag-based collections are appropriate. 
            #Both approaches give the same results. The Tag-based approach requires a few additional steps before running the DESeq2 tool but it will payoff when working with a complex experimental setup.
# DESeq2 generated 3 outputs:

        #A tablewith the normalized counts for each gene (rows) in the samples (columns)
        #A graphical summary of the results, useful to evaluate the quality of the experiment
       
       
        #1) A plot of the first 2 dimensions from a principal component analysis (PCA), run on the normalized counts of the samples
        
                #Let’s imagine we have some beer bottles standing here on the table. We can describe each beer by its colour, its foam, by how strong it is, and so on. We can compose a whole list of different characteristics of each beer in a beer shop. 
                #But many of them will measure related properties and so will be redundant. If so, we should be able to summarize each beer with fewer characteristics. This is what PCA or principal component analysis does.

            #With PCA, we do not just select some interesting characteristics and discard the others. Instead, we construct some new characteristics that summarize our list of beers well. 
            #These new characteristics are constructed using the old ones. For example, a new characteristic might be computed, e.g. foam size minus beer pH. They are linear combinations.

            #In fact, PCA finds the best possible characteristics, the ones that summarize the list of beers. These characteristics can be used to find similarities between beers and group them.

            #Going back to read counts, the PCA is run on the normalized counts for all the samples. Here, we would like to describe the samples based on the expression of the genes. So the characteristics are the number of reads mapped on each genes. We use them and linear combinations of them to represent the samples and their similarities.

            #The beer analogy has been adapted from an answer on StackExchange.
               
               # It shows the samples in the 2D plane spanned by their first two principal components. Each replicate is plotted as an individual data point.
               # This type of plot is useful for visualizing the overall effect of experimental covariates and batch effects.
                  # What is the first dimension (PC1) separating? The first dimension is separating the treated samples from the untreated sample.
                   #3And the second dimension (PC2)? The second dimension is separating the single-end datasets from the paired-end datasets.
                    #What can we conclude about the DESeq design (factors, levels) we choose? The datasets are grouped following the levels of the two factors. 
                    #No hidden effect seems to be present on the data. If there is unwanted variation present in the data (e.g. batch effects), 
                    #it is always recommended to correct for this, which can be achieved in DESeq2 by including in the design any known batch variables.

       #2 Heatmap of the sample-to-sample distance matrix (with clustering) based on the normalized counts.

            #The heatmap gives an overview of similarities and dissimilarities between samples: the color represents the distance between the samples. 
            #Dark blue means shorter distance, i.e. closer samples given the normalized counts.   


        #3          Dispersion estimates: gene-wise estimates (black), the fitted values (red), and the final maximum a posteriori estimates used in testing (blue)

                #This dispersion plot is typical, with the final estimates shrunk from the gene-wise estimates towards the fitted estimates. 
                #Some gene-wise estimates are flagged as outliers and not shrunk towards the fitted value. 
                #The amount of shrinkage can be more or less than seen here, depending on the sample size, the number of coefficients, the row mean and the variability of the gene-wise estimates.
        #4 Histogram of p-values for the genes in the comparison between the 2 levels of the 1st factor
        #5 
                An MA plot:

                #This displays the global view of the relationship between the expression change of conditions (log ratios, M), the average expression strength of the genes (average mean, A), and the ability of the algorithm to detect differential gene expression. The genes that passed the significance threshold (adjusted p-value < 0.1) are colored in red.

                #A summary file with the following values for each gene:

                #Gene identifiers
                #Mean normalized counts, averaged over all samples from both conditions
                #Fold change in log2 (logarithm base 2)

                #The log2 fold changes are based on the primary factor level 1 vs factor level 2, hence the input order of factor levels is important. Here, DESeq2 computes fold changes of ‘treated’ samples against ‘untreated’ from the first factor ‘Treatment’, i.e. the values correspond to up- or downregulation of genes in treated samples.

                #Standard error estimate for the log2 fold change estimate
                #Wald statistic
                #p-value for the statistical significance of this change
                #p-value adjusted for multiple testing with the Benjamini-Hochberg procedure, which controls false discovery rate (FDR)

#Annotation of the DESeq2 results
        #The generated output is an extension of the previous file:

        #Gene identifiers
        #Mean normalized counts over all samples
        #Log2 fold change
        #Standard error estimate for the log2 fold change estimate
        #Wald statistic
       # p-value for the Wald statistic
        #p-value adjusted for multiple testing with the Benjamini-Hochberg procedure for the Wald statistic
        #Chromosome
        #Start
        #End
        #Strand
        #Feature
        #Gene name
        #the annotated table contains no column names, which makes it difficult to read. We would like to add them before going further. you need to concatenate them
        # GeneID	Base mean	log2(FC)	StdErr	Wald-Stats	P-value	P-adj	Chromosome	Start	End	Strand	Feature	Gene name
#Extraction and annotation of differentially expressed genes
#Now we would like to extract the most differentially expressed genes due to the treatment with a fold change > 2 (or < 1/2).

#Visualization of the expression of the differentially expressed genes
#For each gene, we have its ID, its mean normalized counts (averaged over all samples from both conditions), its log_2FC
 #and other information including gene name and position.
 
 #We could plot the log_2FC for the extracted genes, but here we would like to look at a heatmap of expression for these genes in the different samples. So we need to extract the normalized counts for these genes.

    #We proceed in several steps:

   #Extract and plot the normalized counts for these genes for each sample with a heatmap, using the normalized count file generated by DESeq2
    #Compute, extract and plot the Z-score of the normalized counts
# Visualization of the normalized counts
#To extract the normalized counts for the interesting genes, we join the normalized count table generated by DESeq2 with the table we just generated. 
#We will then keep only the columns corresponding to the normalized counts.
#We now have a table with 114 lines (the 113 most differentially expressed genes and a header) and the normalized counts for these genes across the 7 samples.
#Plot the heatmap of the normalized counts of these genes for the samples

#What does the X-axis of the heatmap represent? What about the Y axis? The X-axis shows the 7 samples, together with a dendrogram representing the similarity between their levels of gene expression. 
#The Y-axis shows the 113 differentially expressed genes, likewise with a dendrogram representing the similarity between the levels of gene expression.
#Do you observe anything in the clustering of the samples and the genes? The samples are clustering by treatment.
#What changes if you regenerate the heatmap, this time selecting Plot the data as it is in “Data transformation”? The scale changes and we only see few genes.
#Why cannot we use Log2(value) transform my data in “Data transformation”? Because the normalized expression of the gene FBgn0013688 in GSM461180_treat_paired is at 0
#How could you generate a heatmap of normalized counts for all up-regulated genes with fold change > 2? Extract the genes with log_2FC (filter for genes with c3>1 on the summary of the differentially expressed genes) and run heatmap2 tool on the generated table.

#Visualization of the Z-score
#To compare the gene expression over samples, we could also use the Z-score, which is often represented in publications.

#The Z-score gives the number of standard-deviations that a value is away from the mean of all the values in the same group, here the same gene. A Z-score of -2 for the gene X in sample A means that this value is 2 standard-deviations lower than the mean of the values for gene X in all the samples (A, B, C, etc).

#The Z-score z_i,j
 #for a gene i
 #in a sample j
 #given the normalized count x_i,j
 #is computed as z_i,j=x_i,j−x_i⎯⎯⎯⎯⎯⎯⎯⎯s_i
 #with x_i⎯⎯⎯⎯⎯⎯⎯
 #the mean and s_i
 #the standard deviation of the normalized counts for the gene i
 #over all samples.