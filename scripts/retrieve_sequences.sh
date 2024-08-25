
#!/bin/bash                           
# author: Joshua Ayelazuno
# date: 12-11-2023
# title: .sh to retrieve .fas of Pho4 blastp homologs from the 332 yeast genomes from Shen et al 2018 (PMID: 30415838)
# use:retrive_sequences.sh
#########################
# the input file is a .csv file with species_name and seq_identifier from the blastp hits
input1="/Users/jayelazuno/Desktop/Pho4_orthologs /orthomcl_output/blast_hit_grt1_seq.csv"

# Fasta file in the .fas from the shen et al data
input2="/Users/jayelazuno/Desktop/Pho4_orthologs /orthomcl_output/343taxa_protein.fasta"

# Output folder
#orthologs_retrieved.fas="/Users/jayelazuno/Desktop/Pho4_orthologs /orthomcl_output/blastp_results/orthologs_retrieved.fas"

# Create output folder if it doesn't exist
mkdir -p "$output_folder"

# Read CSV file and extract species_name and seq_identifier
while IFS=, read -r species_name seq_identifier; do
output_label="${species_name}_${seq_identifier}"
# the annotated fasta is labeled with species_name@seq_identifier 
search_string="${species_name}@${seq_identifier}"
grep -A 1 -wF ">$search_string" "$input2" > "${out_results}/${output_label}.fas"
done < "$input"

    # Search for the sequence in the fasta file and save to output file
    grep -A 1 -wF ">$seq_identifier" "$input2" > "$orhologs_retrieved.fas/${output_label}.fas"
done < "$input1"

echo "Sequences retrieval completed. Check the '$orthologs_retrieved.fas' folder for the output files."
