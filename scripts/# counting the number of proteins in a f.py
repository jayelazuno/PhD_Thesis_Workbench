# counting the number of proteins in a fasta file 
file_path = "/path/protein.faa"

# Function to count the number of protein sequences in a FASTA file
def count_fasta_sequences(file_path):
    with open(file_path, "r") as file:
        # Counting lines that start with '>' which indicates the start of a sequence entry
        count = sum(1 for line in file if line.startswith(">"))
    return count

# Count the number of protein sequences in the uploaded FASTA file
protein_count = count_fasta_sequences(fasta_file_path)
protein_count

# can also be done on the bash with with grip 
# grep -c ">" /path/to/your/protein.faa
#grep -c ">": This searches for lines starting with the ">" symbol