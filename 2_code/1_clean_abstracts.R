require(tidyverse)

data = read_csv("1_data/data.csv")

# First, remove copyright claims

# remove from strings text that matches:
# optional: "Copyright "
# "(C)" or "(c)"
# optional: space character
# one or more digits
# any number of printable characters
# end of string
data$Abstracts <- str_remove(data$Abstract, "(Copyright )?\\((C|c)\\)\\s?\\d+[:print:]*$")
