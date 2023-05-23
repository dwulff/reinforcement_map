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


write_csv(data, "1_data/data_cleaned.csv")