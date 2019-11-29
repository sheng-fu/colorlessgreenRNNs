library(tidyverse)
library(jsonlite)
library(directlabels)
library(ggrepel)

setwd("H:/blimp_outputs/")

overall = tibble()

models = c('0.0039M', '0.0079M', '0.0156M', '0.0313M', '0.0625M', '0.125M', '0.25M', '0.5M', '1M', '2M', '4M', '8M', '16M', '32M', '64M', '83M')
#models = c('0.0039M')
runs = c("_1", "_2", "_3", "_4", "_5")

for (num in models){
  for (run in runs)
{
    if (file.exists(paste("blimp-lstm_twoprefix_peephole", num, run, ".jsonl", sep=''))){
two_prefix_lstm <- stream_in(file(paste("blimp-lstm_twoprefix_peephole", num, run, ".jsonl", sep='')))
one_prefix_lstm <- stream_in(file(paste("blimp-lstm_oneprefix_peephole", num, run, ".jsonl", sep='')))
lm_lstm <- stream_in(file(paste("blimp-lstm_simplelm_peephole", num, run, ".jsonl", sep='')))


lm_lstm$linguistics_term = gsub("s-selection", "argument_structure", lm_lstm$linguistics_term)
two_prefix_lstm$linguistics_term = gsub("s-selection", "argument_structure", two_prefix_lstm$linguistics_term)
one_prefix_lstm$linguistics_term = gsub("s-selection", "argument_structure", one_prefix_lstm$linguistics_term)

one_prefix_lstm$one_prefix_prob1 = one_prefix_lstm$prefix_logits1 + one_prefix_lstm$crit_logits1
one_prefix_lstm$one_prefix_prob2 = one_prefix_lstm$prefix_logits2 + one_prefix_lstm$crit_logits2
one_prefix_lstm$pred = one_prefix_lstm$one_prefix_prob1 > one_prefix_lstm$one_prefix_prob2

lm_lstm$pred = lm_lstm$lm_prob1 > lm_lstm$lm_prob2

two_prefix_lstm$two_prefix_prob1 = two_prefix_lstm$prefix_logits1 + two_prefix_lstm$crit_logits1
two_prefix_lstm$two_prefix_prob2 = two_prefix_lstm$prefix_logits2 + two_prefix_lstm$crit_logits2
two_prefix_lstm$pred = two_prefix_lstm$two_prefix_prob1 > two_prefix_lstm$two_prefix_prob2

one_prefix_results = select(one_prefix_lstm, UID, pairID, linguistics_term, pred)
two_prefix_results = select(two_prefix_lstm, UID, pairID, linguistics_term, pred)
lm_results = select(lm_lstm, UID, pairID, linguistics_term, pred)

one_prefix_results$type = "one-prefix"
lm_results$type = "sentence"
two_prefix_results$type = "two-prefix"

broad_results = rbind(lm_results, one_prefix_results, two_prefix_results)
broad_results$size = num
broad_results$run = run
overall = rbind(overall, broad_results)

    }
  }
  
}

overall$size = gsub("M", "", overall$size)
unique(overall$size)

#write.table(overall, "master_results_blimp_191128.tsv", sep = '\t', quote = F, row.names = F)

#overall =  read_tsv("master_results_blimp_191128.tsv")
overall = filter(overall, UID != "wh_questions_object_gap_long_distance",
                         UID != "coordinate_structure_constraint_subject_extraction")

#write.table(overall, "master_results_blimp_191128.tsv", sep = '\t', quote = F, row.names = F)



broad_breakdown = group_by(overall, type, run, size) %>% summarise(m_pred = mean(pred))
broad_breakdown$size = as.numeric(broad_breakdown$size)



View(broad_breakdown)

#write.table(broad_breakdown, "master_breakdown_blimp_191128.tsv", sep = '\t', quote = F, row.names = F)

broad_breakdown = read_tsv("master_breakdown_blimp_191128.tsv")

broad_breakdown = filter(broad_breakdown, size > 0.1)

broad_breakdown$run = gsub("_", "", broad_breakdown$run)
broad_breakdown = filter(broad_breakdown, size != 83)

#View(broad_breakdown)

overall_breakdown = group_by(broad_breakdown, type, size, run) %>% summarise(m_pred = mean(m_pred)) %>%
  group_by(type, size) %>% summarise(sd_pred = sd(m_pred), m_pred = mean(m_pred))

narrow_breakdown = group_by(broad_breakdown, linguistics_term, type, size) %>% 
  summarise(sd_pred = sd(m_pred),   m_pred = mean(m_pred))

narrow_breakdown

narrow_breakdown$linguistics_term = factor(narrow_breakdown$linguistics_term)
levels(narrow_breakdown$linguistics_term) = c("Ana. Agr", "Arg. Str", "Binding", "Ctrl. Rais.", 
                                              "D-N Agr", "Ellipsis", "Filler Gap.", "Irregular",
                                              "Island", "NPI", "Quantifiers", "S-V Agr")
narrow_breakdown$linguistics_term = as.character(narrow_breakdown$linguistics_term)


simple_lm = filter(narrow_breakdown, type == 'sentence')
simple_lm_overall = filter(ungroup(overall_breakdown), type == 'sentence') %>% select(size, type, sd_pred, m_pred)
simple_lm_overall$linguistics_term = "OVERALL"



# p = ggplot(simple_lm, aes(x = epoch, y = m_pred, group = linguistics_term, colour = linguistics_term)) + 
#   geom_line(aes(color=linguistics_term), size = 1.2)+
#   geom_point(aes(color=linguistics_term), size = 2)+
#   scale_colour_discrete(guide = 'none') +  ylab("accuracy") + xlab('training size (M)') +
#   theme(
#     axis.title.x = element_text(size = 16),
#     axis.text.x = element_text(size = 14),
#     axis.title.y = element_text(size = 16)) +
#   scale_x_discrete(expand = expand_scale(mult = c(0.1, .4))) +
#   geom_dl(aes(label = linguistics_term), method = list(dl.trans(x = x + .3), 
#                           "maxvar.qp", cex = 1.5, hjust = -1)) 
# 
# p

#simple_lm = filter(simple_lm, epoch != '32', epoch != '64')

simple_lm1 = mutate(simple_lm, label = if_else(size == 64, 
            as.character(linguistics_term), NA_character_))

simple_lm_overall1 = mutate(simple_lm_overall, label = if_else(size == 64, 
                                               as.character(linguistics_term), NA_character_))

#View(simple_lm)


xlabels = c("125K", "250K", "500K", "1M", "2M", "4M", "8M", "16M", "32M", "64M")

p = ggplot(simple_lm1, aes(x = size, y = m_pred)) + 
  geom_line(data = simple_lm_overall1, aes(size, m_pred), size = 3, alpha=0.45) +
  geom_line(aes(color=linguistics_term), size = 1.2)+ xlim(0,9) +
  geom_point(aes(color=linguistics_term), size = 2)+ xlab("training size (tokens)") +
    ylab("accuracy") +
  scale_x_continuous(trans='log2', labels = xlabels, breaks = unique(simple_lm1$size),
                     expand = expand_scale(mult = c(0.1, .3))) + 
  scale_y_continuous(labels = as.character(c(0.25, 0.5, 0.75, 1)), 
                     breaks = c(0.25, 0.5, 0.75, 1), limits = c(0.25, 1)) +
  geom_errorbar(aes(ymin=m_pred-sd_pred, ymax=m_pred+sd_pred, color=linguistics_term), width=0.2) +
  theme(legend.position = "none",
    axis.title.x = element_text(size = 25),
    axis.text.x = element_text(size = 23),
    axis.text.y = element_text(size = 23),
    axis.title.y = element_text(size = 25)) + 
  geom_label_repel(aes(label = label, color=linguistics_term), direction = "y", nudge_x = 5, na.rm = TRUE, hjust = 1, cex = 10)

p

###gain over prefix

comp_breakdown = group_by(overall, linguistics_term, type, size, run, UID) %>% summarise(m_pred = mean(pred))
comp_breakdown$size = as.numeric(comp_breakdown$size)


one_prefix_UIDs = comp_breakdown[comp_breakdown$type == 'one-prefix',]$UID
two_prefix_UIDs = comp_breakdown[comp_breakdown$type == 'two-prefix',]$UID


comp_breakdown_1 = comp_breakdown
comp_breakdown_1$term_type = paste(comp_breakdown_1$linguistics_term, '_', comp_breakdown_1$type, sep = '')

overall_1prefix =  filter(comp_breakdown_1, UID %in% one_prefix_UIDs)
overall_1prefix = group_by(overall_1prefix, term_type, size, run) %>% summarise(m_pred = mean(m_pred))
overall_1prefix = group_by(overall_1prefix, term_type, size) %>% summarise(sd_pred = sd(m_pred), m_pred = mean(m_pred))



overall_1prefix = mutate(overall_1prefix, label = if_else(size == 64, 
                                          as.character(term_type), NA_character_))

overall_1prefix

p_overall_1prefix = ggplot(overall_1prefix, aes(x = size, y = m_pred, group = term_type, colour = term_type)) + 
  geom_line(aes(color=term_type), size = 1.2)+ xlim(0,9) +
  geom_point(aes(color=term_type), size = 2)+ xlab("training size (M)") +
  scale_colour_discrete(guide = 'none') +  ylab("accuracy") + 
  scale_x_continuous(trans='log2', labels = as.character(unique(one_prefix1$size)), 
                     breaks = unique(one_prefix1$size),
                     expand = expand_scale(mult = c(0.1, .4))) +
  geom_errorbar(aes(ymin=m_pred-sd_pred, ymax=m_pred+sd_pred), width=0.2) +
  theme(
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 14),
    axis.title.y = element_text(size = 16)) + ggtitle('simple LM vs. 1-prefix results') +
  geom_label_repel(aes(label = label), direction = "y", nudge_x = 3, na.rm = TRUE, hjust = 0, cex = 4)

p_overall_1prefix


overall_2prefix =  filter(comp_breakdown_1, UID %in% two_prefix_UIDs)
overall_2prefix = group_by(overall_2prefix, term_type, run, size) %>% summarise(m_pred = mean(m_pred))

overall_2prefix = group_by(overall_2prefix, term_type, size) %>% summarise(sd_pred = sd(m_pred),
                                                                           m_pred = mean(m_pred))

overall_2prefix = mutate(overall_2prefix, label = if_else(size == 64, 
                                                          as.character(term_type), NA_character_))

overall_2prefix

p_overall_2prefix = ggplot(overall_2prefix, aes(x = size, y = m_pred, group = term_type, colour = term_type)) + 
  geom_line(aes(color=term_type), size = 1.2)+ xlim(0,9) +
  geom_point(aes(color=term_type), size = 2)+ xlab("training size (M)") +
  scale_colour_discrete(guide = 'none') +  ylab("accuracy") + 
  scale_x_continuous(trans='log2', labels = as.character(unique(overall_2prefix$size)), 
                     breaks = unique(overall_2prefix$size),
                     expand = expand_scale(mult = c(0.1, .4))) +
  geom_errorbar(aes(ymin=m_pred-sd_pred, ymax=m_pred+sd_pred), width=0.2) +
  theme(
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 14),
    axis.title.y = element_text(size = 16)) + ggtitle('simple LM vs. 2-prefix results') +
  geom_label_repel(aes(label = label), direction = "y", nudge_x = 3, na.rm = TRUE, hjust = 0, cex = 4)

p_overall_2prefix


PP = read_tsv("C:\\Users\\Sheng-Fu\\Documents\\GitHub\\colorlessgreenRNNs\\results\\outputs\\LM_PP.txt")
PP = filter(PP, size != 83, is.na(PP) != T)
PP = group_by(PP, size) %>% summarise(pp_sd = sd(PP), pp_m = mean(PP))
PP

p_PP = ggplot(PP, aes(x = size, y = pp_m)) + 
  geom_line(aes(color=term_type), size = 1.2)+ xlim(0,9) +
  geom_point(aes(color=term_type), size = 2)+ xlab("training size (M)") +
  scale_colour_discrete(guide = 'none') +  ylab("accuracy") + 
  scale_x_continuous(trans='log2', labels = as.character(unique(PP$size)), 
                     breaks = unique(PP$size),
                     expand = expand_scale(mult = c(0.1, .4))) +
  geom_errorbar(aes(ymin=pp_m-pp_sd, ymax=pp_m+pp_sd), width=0.2) +
  theme(
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 14),
    axis.title.y = element_text(size = 16)) 
p_PP
