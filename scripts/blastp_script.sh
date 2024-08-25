#!/bin/bash
#########################
# author: Joshua Ayelazuno
# date: 11-30-2023
# title: blastp to identify putative Pho4 homologs in the 332 yeast genomes from Shen et al 2018 (PMID: 30415838)
# use: blastp_script.sh
#########################

# These are useful flags to set to make the code more robust to failure
# Copied from Vince Buffalo's Bioinformatic Data Analysis book
set -e
set -u
set -o pipefail

# Parameters
query_file="/jayelazuno/Desktop/Pho4_orthologs/orthomcl_output/S288C_YFR034C_PHO4_protein.fsa"
base_output_path="/Users/jayelazuno/Desktop/Pho4_orthologs/orthomcl_output/blastp_results"
subject_file="/Users/jayelazuno/Desktop/Pho4_orthologs/orthomcl_output/343taxa_proteins.fasta"

# blastp
echo "Running blastp with custom parameters..."
blastp -query "$query_file" -subject "$subject_file" -out "$base_output_path/blastp_results.asn" -evalue 1e-10 -outfmt 11 
-num_threads 12 # -num_threads = cpu cores
# -query: path to the query file
# -subject: path to the subject file
# -out: output file path for the results
# -evalue: E-value threshold for considering matches
# -outfmt: output format (6 for tabular format)
# -num_threads: number of threads to use
echo "blastp complete"

# Reformatting
echo "Reformatting..."

#blast_formatter -archive "$base_output_path/blastp_results.txt" -outfmt 3 -out "$base_output_path/blastp_results.flat"
#blast_formatter -archive "$base_output_path/blastp_results.txt" -outfmt 3 -out "$base_output_path/blastp_results.flat"
blast_formatter -archive "$base_output_path/blastp_results.txt" -outfmt "7 sseqid qcovs qstart qend slen sstart send qcovshsp 
pident mismatch evalue" -out "$base_output_path/blastp_results.txt"
#blast_formatter -archive "$base_output_path/blastp_results.txt" -outfmt "6 sseqid sseq" -out 
"$base_output_path/blastp_results.fasta"
#sseqid: Subject sequence ID. This is the identifier of the sequence in the subject database that the query sequence aligned 
with.
#qcovs: Query coverage per subject. It represents the percentage of the query sequence that is covered by the alignment with the 
subject sequence.
#qstart: Start position of the alignment on the query sequence.
#qend: End position of the alignment on the query sequence.
#slen: Length of the subject sequence.
#sstart: Start position of the alignment on the subject sequence.
#send: End position of the alignment on the subject sequence.
#qcovshsp: Query coverage per high-scoring pair. It represents the percentage of the query sequence that is covered by the 
high-scoring pair.
#pident: Percentage of identical matches. It represents the percentage of nucleotides or amino acids in the alignment that are 
identical between the query and subject sequences.
#mismatch: Number of mismatches in the alignment.
#evalue: E-value, or Expectation value. It represents the expected number of chance matches with a similar or better score that 
could occur in the database by random chance     
echo "Done"

