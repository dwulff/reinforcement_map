require(tidyverse)

data = read_csv("1_data/data.csv")

# First, remove copyright claims

# remove from strings text that matches:
# optional: "Copyright "
# "(C)" or "(c)"
# optional: space character
# one or more digits (= year)
# any number of printable characters
# end of string
data$Abstract_cleaned <- str_remove(data$Abstract, "(Copyright )?\\((C|c)\\)\\s?\\d+[:print:]*$")

# some copyright marks do not match the pattern above, replace them manually
copyright_strings <- c("\\(C\\) Copyright 2014 Textrum Ltd. All rights reserved." ,
                       "\\(C\\) Elsevier B.V. All rights reserved.",
                       "Copyright \\(c\\), 2008 John Wiley & Sons, Ltd.",
                       "\\(C\\)& nbsp;2022 The Authors. Published by Elsevier Ltd.",
                       "\\(C\\) Copyright 2014 Textrum Ltd. All rights reserved."
                       )

for (copyright_string in copyright_strings) {
  data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, copyright_string)
}


# remove organizers

organizers <- c("S[Ii][Gg][Nn][Ii][Ff][Ii][Cc][Aa][Nn][Cc][Ee][:punct:][^[A-Z]]",
                "S[Ii][Gg][Nn][Ii][Ff][Ii][Cc][Aa][Nn][Cc][Ee][:blank:]*(?=[A-Z])",
                "B[Aa][Cc][Kk][Gg][Rr][Oo][Un][Nn][Dd][:punct:][^[A-Z]]",
                "B[Aa][Cc][Kk][Gg][Rr][Oo][Un][Nn][Dd][:blank:]*(?=[A-Z])",
                "I[Nn][Tt][Rr][Oo][Dd][Uu][Cc][Tt][Ii][Oo][Nn][Ss]{0,1}[:punct:][^[A-Z]]",
                "I[Nn][Tt][Rr][Oo][Dd][Uu][Cc][Tt][Ii][Oo][Nn][Ss]{0,1}[:blank:]*(?=[A-Z])",
                "R[Aa][Tt][Ii][Oo][Nn][Aa][Ll][Ee][Ss]{0,1}[:punct:][^[A-Z]]",
                "R[Aa][Tt][Ii][Oo][Nn][Aa][Ll][Ee][Ss]{0,1}[:blank:]*(?=[A-Z])",
                "P[Uu][Rr][Pp][Oo][Ss][Ee][Ss]{0,1}[:punct:][^[A-Z]]",
                "P[Uu][Rr][Pp][Oo][Ss][Ee][Ss]{0,1}[:blank:]*(?=[A-Z])",
                "I[Mm][Pp][Oo][Rr][Tt][Aa][Nn][Cc][Ee][:punct:][^[A-Z]]",
                "I[Mm][Pp][Oo][Rr][Tt][Aa][Nn][Cc][Ee][:blank:]*(?=[A-Z])",
                "M[Ee][Tt][Hh][Oo][Dd][Ss]{0,1}[:punct:][^[A-Z]]",
                "M[Ee][Tt][Hh][Oo][Dd][Ss]{0,1}[:blank:]*(?=[A-Z])",
                "A[Ii][Mm][Ss]{0,1}[:punct:][^[A-Z]]",
                "A[Ii][Mm][Ss]{0,1}[:blank:]*(?=[A-Z])",
                "F[Ii][Nn][Dd][Ii][Nn][Gg][Ss]{0,1}[:punct:][^[A-Z]]",
                "F[Ii][Nn][Dd][Ii][Nn][Gg][Ss]{0,1}[:blank:]*(?=[A-Z])",
                "C[Oo][Nn][Cc][Ll][Uu][Ss][Ii][Oo][Nn][Ss]{0,1}[:punct:][^[A-Z]]",
                "C[Oo][Nn][Cc][Ll][Uu][Ss][Ii][Oo][Nn][Ss]{0,1}[:blank:]*(?=[A-Z])")



for (organizer in organizers) {
  data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, organizer)
}

data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Journal of the Operational Research Society \\(2011\\) 62, 515-525. doi:10.1057/jors.2010.96 Published online 25 August 2010")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\(2012\\) 37, 618-629; doi: 10.1038/npp.2011.227; published online 28 September 2011")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\(2012\\) 37, 1945-1952; doi:10.1038/npp.2012.41; published online 11 April 2012")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\(2010\\) 35, 2155-2164; doi:10.1038/npp.2010.84; published online 14 July 2010")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Journal of the Operational Research Society \\(2012\\) 63, 1165-1173. doi: 10.1057/jors.2011.94 Published online 21 December 2011")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Journal of the Operational Research Society \\(2011\\) 62, 281-290. doi:10.1057/jors.2010.101 Published online 25 August 2010")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\(2009\\) 34, 1649-1658; doi:10.1038/npp.2008.222; published online 17 December 2008")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Translational Psychiatry \\(2013\\) 3, e213; doi:10.1038/tp.2012.134; published online 15 January 2013")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Clark AM. Reward processing: a global brain phenomenon\\? J Neurophysiol 109: 1-4, 2013. First published July 18, 2012; doi:10.1152/jn.00070.2012.-")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Madelain L, Paeye C, Wallman J. Modification of saccadic gain by reinforcement. J Neurophysiol 106: 219-232, 2011. First published April 27, 2011; doi:10.1152/jn.01094.2009.-")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Yamada H, Inokawa H, Matsumoto N, Ueda Y, Enomoto K, Kimura M. Coding of the long-term value of multiple future rewards in the primate striatum. J Neurophysiol 109: 1140-1151, 2013. First published November 21, 2012; doi:10.1152/jn.00289.2012.-")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\(2009\\) 34, 2691-2698; doi:10.1038/npp.2009.95; published online 12 August 2009")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Bermudez MA, Schultz W. Reward magnitude coding in primate amygdala neurons. J Neurophysiol 104: 3424-3432, 2010. First published September 22, 2010; doi:10.1152/jn.00540.2010. ")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\( 2010\\) 35, 1485-1499; doi: 10.1038/npp.2010.18; published online 10 March 2010")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Neuropsychopharmacology \\(2012\\) 37, 2031-2046; doi:10.1038/npp.2012.51; published online 2 May 2012")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Valentin VV, O'Doherty JP. Overlapping prediction errors in dorsal striatum during instrumental learning with juice and money reward in the human brain. J Neurophysiol 102: 3384-3391, 2009. First published September 30, 2009; doi:10.1152/jn.91195.2008.")
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Bromberg-Martin ES, Matsumoto M, Hong S, Hikosaka O. A pallidus-habenula-dopamine pathway signals inferred stimulus values. J Neurophysiol 104: 1068-1076, 2010. First published June 10, 2010; doi: 10.1152/jn.00158.2010.") 
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Originality/value") 
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "This is an open access article under the CC BY license.") 
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "\\[GRAPHICS\\]") 
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Results and interpretation:") 
data$Abstract_cleaned <- str_remove(data$Abstract_cleaned, "Public [Ss]ignificance [Ss]tatement")

write_csv(data, "1_data/data_cleaned.csv")
