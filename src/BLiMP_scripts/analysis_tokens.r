library(tidyverse)
library(jsonlite)



two_prefix_lstm <- stream_in(file("blimp-lstm_twoprefix_peephole.jsonl"))
one_prefix_lstm <- stream_in(file("blimp-lstm_oneprefix_peephole.jsonl"))
lm_lstm <- stream_in(file("blimp-lstm_simplelm_peephole.jsonl"))


#load results in tab
#two_prefix_lstm = read_tsv('blimp-lstm_twoprefix_peephole.tab')
#lm_lstm = read_tsv('blimp-lstm_simplelm_peephole.tab')
#one_prefix_lstm = read_tsv('blimp-lstm_oneprefix_peephole.tab')

lm_lstm$linguistics_term = gsub("s-selection", "argument_structure", lm_lstm$linguistics_term)
two_prefix_lstm$linguistics_term = gsub("s-selection", "argument_structure", two_prefix_lstm$linguistics_term)
one_prefix_lstm$linguistics_term = gsub("s-selection", "argument_structure", one_prefix_lstm$linguistics_term)

colnames(one_prefix_lstm)

one_prefix_lstm$one_prefix_prob1 = one_prefix_lstm$prefix_logits1 + one_prefix_lstm$crit_logits1
one_prefix_lstm$one_prefix_prob2 = one_prefix_lstm$prefix_logits2 + one_prefix_lstm$crit_logits2
one_prefix_lstm$pred = one_prefix_lstm$one_prefix_prob1 > one_prefix_lstm$one_prefix_prob2

lm_lstm$pred = lm_lstm$lm_prob2 > lm_lstm$lm_prob1

colnames(two_prefix_lstm)

#View(two_prefix_lstm)

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

broad_breakdown = group_by(broad_results, UID, linguistics_term, type) %>% summarise(m_pred = mean(pred))
broad_breakdown

write_tsv(broad_breakdown, "lstm_broad_breakdown.tsv")

cat_12 = group_by(broad_breakdown, linguistics_term, type) %>% filter(type == 'sentence') %>%  summarise(m_pred = mean(m_pred))
cat_12

write_tsv(cat_12, "lstm_cat_12_breakdown.tsv")


group_by(broad_breakdown, type) %>% filter(type == 'sentence') %>%  summarise(m_pred = mean(m_pred))


colnames(one_prefix_lstm)

one_prefix_lstm$lm_pred = one_prefix_lstm$lm_prob1 > one_prefix_lstm$lm_prob2
one_prefix_lstm$append_pred = one_prefix_lstm$append_logits1 >one_prefix_lstm$append_logits2
one_prefix_lstm$crit_pred = one_prefix_lstm$crit_logits1 > one_prefix_lstm$crit_logits2
one_prefix_lstm$append_ent_pred = one_prefix_lstm$appen_entropy1 > one_prefix_lstm$appen_entropy2

one_prefix_lstm_breakdown = group_by(one_prefix_lstm, linguistics_term, UID) %>% 
  summarise(m_lm_pred = mean(lm_pred),
              m_append_pred = mean(append_pred),
              m_crit_pred = mean(crit_pred),
              m_append_ent_pred = mean(append_ent_pred),
              m_pred = mean(pred))
#View(one_prefix_lstm_breakdown)

one_prefix_lstm$lm_pred_cat = as.factor(one_prefix_lstm$lm_pred)

ggplot(one_prefix_lstm, aes(x = (crit_logits1 - crit_logits2), y = (append_logits1 - append_logits2), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~UID) + ggtitle("LSTM, Critical vs. Appendix logits") +
  geom_abline(intercept = 0, slope = -1)


one_prefix_lstm_binding = filter(one_prefix_lstm, linguistics_term == 'binding')

ggplot(one_prefix_lstm_binding, aes(x = (lm_prob1 - lm_prob2), y = (append_logits1 - append_logits2), color = lm_pred_cat)) + 
  geom_point() + facet_wrap(~UID) 

write_tsv(one_prefix_lstm_breakdown, "one_prefix_lstm_breakdown.tab")

two_prefix_lstm$lm_pred = two_prefix_lstm$lm_prob1 > two_prefix_lstm$lm_prob2
two_prefix_lstm$append_pred = two_prefix_lstm$append_logits1 > two_prefix_lstm$append_logits2
two_prefix_lstm$crit_pred = two_prefix_lstm$crit_logits1 > two_prefix_lstm$crit_logits2
two_prefix_lstm$append_ent_pred = two_prefix_lstm$appen_entropy1 > two_prefix_lstm$appen_entropy2

colnames(two_prefix_lstm)

two_prefix_lstm$lm_pred_cat = as.factor(two_prefix_lstm$lm_pred)

ggplot(two_prefix_lstm, aes(x = (two_prefix_prob1 - two_prefix_prob2), y = (append_logits1 - append_logits2), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~UID)  + ggtitle("LSTM, Prefix + Critical vs. Appendix logits")

ggplot(two_prefix_lstm, aes(x = (crit_logits1 - crit_logits2), y = (prefix_logits1 - prefix_logits2), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~UID) + ggtitle("LSTM, Prefix  vs. Critical logits") +
  geom_abline(intercept = 0, slope = -1)

unique(two_prefix_lstm$UID)

two_prefix_lstm_breakdown = group_by(two_prefix_lstm, UID, linguistics_term) %>% 
  summarise(m_lm_pred = mean(lm_pred),
            m_append_pred = mean(append_pred),
            m_crit_pred = mean(crit_pred),
            m_append_ent_pred = mean(append_ent_pred),
            m_pred = mean(pred))

two_prefix_lstm_breakdown

write_tsv(two_prefix_lstm_breakdown, "two_prefix_lstm_breakdown.tab")

###gpt2 results
one_prefix_gpt2 <- stream_in(file("blimp-gpt2_oneprefix.jsonl"))
two_prefix_gpt2 <- stream_in(file("blimp-gpt2_twoprefix.jsonl"))
lm_gpt2 <- stream_in(file("blimp-gpt2_simplelm.jsonl"))


one_prefix_gpt2 = merge(lm_gpt2, one_prefix_gpt2, 
                    by = intersect(colnames(lm_gpt2), colnames(one_prefix_gpt2)))


two_prefix_gpt2 = merge(lm_gpt2, two_prefix_gpt2,  
                    by = intersect(colnames(lm_gpt2), colnames(two_prefix_gpt2)))


colnames(one_prefix_gpt2)

one_prefix_gpt2$lm_pred = one_prefix_gpt2$lm_prob1 > one_prefix_gpt2$lm_prob2
one_prefix_gpt2$append_pred = one_prefix_gpt2$appen_logits1 > one_prefix_gpt2$appen_logits2
one_prefix_gpt2$crit_pred = one_prefix_gpt2$crit_logits1 > one_prefix_gpt2$crit_logits2
one_prefix_gpt2$append_ent_pred = one_prefix_gpt2$appen_entropy1 > one_prefix_gpt2$appen_entropy2
one_prefix_gpt2$lm_pred_cat = as.factor(one_prefix_gpt2$lm_pred)


ggplot(one_prefix_gpt2, aes(x = (crit_logits1 - crit_logits2), y = (appen_logits1 - appen_logits2), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~UID) + ggtitle("GPT2, Critical vs. Appendix logits")

colnames(two_prefix_gpt2)

two_prefix_gpt2$lm_pred = two_prefix_gpt2$lm_prob1 > two_prefix_gpt2$lm_prob2
two_prefix_gpt2$append_pred = two_prefix_gpt2$appen_logits1 > two_prefix_gpt2$appen_logits2
two_prefix_gpt2$crit_pred = two_prefix_gpt2$crit_logits1 > two_prefix_gpt2$crit_logits2
two_prefix_gpt2$append_ent_pred = two_prefix_gpt2$appen_entropy1 > two_prefix_gpt2$appen_entropy2
two_prefix_gpt2$pref_crit_logits1 = two_prefix_gpt2$crit_logits1 + two_prefix_gpt2$pref_logits1
two_prefix_gpt2$pref_crit_logits2 = two_prefix_gpt2$crit_logits2 + two_prefix_gpt2$pref_logits2
two_prefix_gpt2$lm_pred_cat = as.factor(two_prefix_gpt2$lm_pred)

ggplot(two_prefix_gpt2, aes(x = (pref_crit_logits1 - pref_crit_logits2), y = (appen_logits1 - appen_logits2), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~UID) + ggtitle("GPT2, Prefix + Critical vs. Appendix logits")

ggplot(two_prefix_gpt2, aes(x = (crit_logits1 - crit_logits2), y = (pref_logits1 - pref_logits2), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~UID) + ggtitle("GPT2, Prefix  vs. Critical logits")

two_prefix_lstm$lm_pred_cat = as.factor(two_prefix_gpt2$lm_pred)

View(two_prefix_gpt2)





