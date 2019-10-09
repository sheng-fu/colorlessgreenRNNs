library(tidyverse)
library(jsonlite)

setwd("~/GitHub/colorlessgreenRNNs/src/analysis")

sentence_path = "~/GitHub/colorlessgreenRNNs/results/blimp/txt_sentence/"
sentence_file = list.files(sentence_path)
sentence_file = sentence_file[grepl("_parsed", sentence_file)]

jsonl_path = "../../data/blimp/jsonl/"

result_sent = tibble()
for (file in sentence_file){
  result = read_tsv(paste(sentence_path, file, sep = ""), col_names = c("good_prob", "bad_prob"))
  no_ext = gsub("_output_parsed\\.tab", "", file)
  data = stream_in(file(paste(jsonl_path, no_ext, ".jsonl", sep="")))
  data = as_data_frame(data)
  data = select(data, sentence_good, sentence_bad,
                field, linguistics_term, UID, 
                simple_LM_method, one_prefix_method, two_prefix_method, 
                lexically_identical)
  result = cbind(data, result)
  #print(colnames(result))
  result_sent = rbind(result_sent, result)

}

result_sent$type = "sentence"

prefix_path = "~/GitHub/colorlessgreenRNNs/results/blimp/txt_one_prefix/"
prefix_file = list.files(prefix_path)
prefix_file = prefix_file[grepl("_parsed", prefix_file)]

result_prefix = tibble()
for (file in prefix_file){
  result = read_tsv(paste(prefix_path, file, sep = ""), col_names = c("good_prob", "bad_prob"))
  no_ext = gsub("_output_parsed\\.tab", "", file)
  data = stream_in(file(paste(jsonl_path, no_ext, ".jsonl", sep="")))
  data = as_data_frame(data)
  data = select(data, sentence_good, sentence_bad,  
                field, linguistics_term, UID, 
                simple_LM_method, one_prefix_method, two_prefix_method, 
                lexically_identical)
  result = cbind(data, result)
  #print(colnames(result))
  result_prefix = rbind(result_prefix, result)
  
}

two_prefix_path = "~/GitHub/colorlessgreenRNNs/results/blimp/txt_two_prefix/"
two_prefix_file = list.files(two_prefix_path)
two_prefix_file = two_prefix_file[grepl("_parsed", two_prefix_file)]
two_prefix_file

result_two_prefix = tibble()
for (file in two_prefix_file){
  result = read_tsv(paste(two_prefix_path, file, sep = ""), col_names = c("good_prob", "bad_prob"))
  no_ext = gsub("_output_parsed\\.tab", "", file)
  data = stream_in(file(paste(jsonl_path, no_ext, ".jsonl", sep="")))
  data = as_data_frame(data)
  data = select(data, sentence_good, sentence_bad,  
                field, linguistics_term, UID, 
                simple_LM_method, one_prefix_method, two_prefix_method, 
                lexically_identical)
  result = cbind(data, result)
  #print(colnames(result))
  result_two_prefix = rbind(result_two_prefix, result)
  
}


result_sent$type = "sentence"
result_prefix$type = "one-prefix"
result_two_prefix$type = "two-prefix"
result_all = rbind(result_sent, result_prefix, result_two_prefix)

result_all$prob_dec = result_all$good_prob < result_all$bad_prob


breakdown = group_by(result_all, UID, type, linguistics_term) %>% summarise(acc = mean(prob_dec), n = n())
  
group_by(result_all, type) %>% summarise(acc = mean(prob_dec), n = n())



View(breakdown)  

write.table(result_all, "blimp_full.tsv", sep='\t', quote=F, row.names = F)
write.table(breakdown, "blimp_breakdown.tsv", sep='\t', quote=F, row.names = F)


