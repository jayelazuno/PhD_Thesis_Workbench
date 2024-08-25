#!/bin/bash
#Title: Hmmscan Pfam database against curated orthologs
# Author: Joshua Ayelazuno
# Date: 01/24/2024



# This script searches for putative curated ScPho4 orthologs against Pfam using HMMER and checks for the presence of the S. cerevisiae Pho4 bHLH domain, as well as returns any other hits
# # .sh assumes that hmmer has beeen installed locally, if not check http://eddylab.org/software/hmmer/Userguide.pdf
# Also, the Pfam data base has been downloaded and hmmpress to create binary files for hmmscan 
# Set paths to HMMER and Pfam database
HMMER_PATH="/usr/local/bin/hmmscan"
PFAM_DB="/Users/jayelazuno/Pfam.hmm/Pfam-A.hmm"  # Replace with the path to your Pfam-A.hmm file

# Set the threshold E-value for reporting hits
EVALUE_THRESHOLD=1e-3

# Set the path to the directory containing your putative Pho4 ortholog sequences in FASTA format
SEQUENCE_FILE="/Users/jayelazuno/Desktop/Pho4_orthologs /orthomcl_output/20231212-343taxa-proteins-homologs.fasta"

# Output directory
OUTPUT_DIR="/Users/jayelazuno/Desktop/Pho4_orthologs/20240124_Hmmscan_output"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
# Specify output files
CSV_OUTPUT="$OUTPUT_DIR/20240124_Hmmscan_Pfam.csv"
TXT_OUTPUT="$OUTPUT_DIR/20240124_Hmmscan_Pfam.txt"
# Perform Hmmscan search against Pfam
"$HMMER_PATH" --tblout "$CSV_OUTPUT" --domtblout "$TXT_OUTPUT" -E "$EVALUE_THRESHOLD" "$PFAM_DB" "$SEQUENCE_FILE"

# --domtblout: output a simpler and parsable table output with one row per domain hit
# --noali: don't output the alignment to make the output more readable
# output file format 
#target name: The name of the target sequence or profile.
#accession: The accession of the target sequence or profile, or ’-’ if none.
#query name: The name of the query sequence or profile.
#accession: The accession of the query sequence or profile, or ’-’ if none.
# E-value: The expectation value (statistical significance) of the target, as above.
# score (full sequence): The score (in bits) for this target/query comparison. It includes the biased-composition correction (the “null2” model).
#Bias (full sequence): The biased-composition correction: the bit score difference contributed by the null2 model. High bias scores may be a red flag for a false positive, especially when the bias
#hmmfrom/to: The position in the hmm at which the hit starts or ends 
#ali to/from 
#The position in the target sequence at which the hit starts/end 
#envfrom/to: The position in the target sequence at which the surrounding envelope starts/ends