library(tidyverse)

galaxy_data <- read_lines("suites_dw_Table1.txt")


sep_line <- (substr(galaxy_data, 0, 2) == "--") %>% 
  which() %>% 
  min()

cat(galaxy_data[1:(sep_line-2)],  sep = "\n", file = "Galaxy Data Variables")

variable_names <- 
  str_split(string = galaxy_data[(sep_line-1)], pattern = "\\|") %>% 
  unlist() %>%  
  str_trim()

comma_separated_values <-
  galaxy_data[(sep_line+1:length(galaxy_data))] %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .)

comma_separated_values_with_names <- 
  c(paste(variable_names, collapse = ","),
    comma_separated_values)

cat(comma_separated_values_with_names, sep = "\n", file = "galaxy_csv")

galaxy <- read_csv("galaxy_csv")





### some unsuccessful own attempts
cat(galaxy_data[(sep_line-1):(sep_line+1000)], sep = "\n", file = "Galaxy Data Table")

galaxy_table <- read_delim("Galaxy Data Table", "|")
galaxy_table <- 
  galaxy_table %>% 
  filter(row_number()!= 1) %>% 
  as.data.frame(apply(2, str_remove_all, " "))

as_tibble(galaxy_table)

cat(galaxy_table, file = "Final Galaxy")
###
