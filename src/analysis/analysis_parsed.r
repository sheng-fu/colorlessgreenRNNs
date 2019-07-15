library(tidyverse)
library(jsonlite)

setwd("~/GitHub/colorlessgreenRNNs/src/analysis")

data = stream_in(file("../../data/sent_pair/simple_anaphor_number_agreement.jsonl"))
data = as_data_frame(data)

result = read_tsv("../../data/sent_pair/test_simp_output_parsed.txt", col_names = c("good_prob", "bad_prob"))

output = cbind(data, result)
output$prob_dec = output$good_prob < output$bad_prob

table(output$prob_dec)

output[output$prob_dec == F,]
