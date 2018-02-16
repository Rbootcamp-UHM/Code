dna <- sample( bases, 500, replace=T)
basefreq <- table(dna)/length(dna)

aas <- which( dna == "a") # position along the dna where there is an "a"
ats <- dna[aas+1] == "t"  # of the aas, which have tʻs next door?
a_gs <- dna[aas+2] == "g" # of the aas, which have gʻs next next door?
match <- aas[ which( ats & a_gs ) ] # the indices where a is followed by t and g

match
dna[ match ]

### Same as above but different choice of variable names: (maybe itʻs more intuitive?)

	n <- which(dna== "a" )   # the index position of "a"s in sequence seq1
	match2 <- dna[ n + 1 ] == "t"    # does codon position 2 match "t"? 
	match3 <- dna[ n + 2 ] == "g"  # does codon position 3 match "g"?
	match123	<- n[ which( match2 & match3 )]  # index position of all matching codons (where all 3 match)

match
dna[ match123 ]