library(tidyverse)


#load results in tab
two_prefix_lstm = read_tsv('blimp-lstm_twoprefix_peephole.tab')
lm_lstm = read_tsv('blimp-lstm_simplelm_peephole.tab')
one_prefix_lstm = read_tsv('blimp-lstm_oneprefix_peephole.tab')

lm_lstm$UID = gsub("s-selection", "argument", lm_lstm$UID)
two_prefix_lstm$UID = gsub("s-selection", "argument", two_prefix_lstm$UID)
one_prefix_lstm$UID = gsub("s-selection", "argument", one_prefix_lstm$UID)

colnames(one_prefix_lstm)

one_prefix_lstm$one_prefix_prob1 = one_prefix_lstm$prefix_logits1 + one_prefix_lstm$crit_logits1
one_prefix_lstm$one_prefix_prob2 = one_prefix_lstm$prefix_logits2 + one_prefix_lstm$crit_logits2
one_prefix_lstm$pred = one_prefix_lstm$one_prefix_prob2 > one_prefix_lstm$one_prefix_prob1

lm_lstm$pred = lm_lstm$lm_prob2 > lm_lstm$lm_prob1

colnames(two_prefix_lstm)

View(two_prefix_lstm)

two_prefix_lstm$two_prefix_prob1 = two_prefix_lstm$prefix_logits1 + two_prefix_lstm$crit_logits1
two_prefix_lstm$two_prefix_prob2 = two_prefix_lstm$prefix_logits2 + two_prefix_lstm$crit_logits2
two_prefix_lstm$pred = two_prefix_lstm$two_prefix_prob2 > two_prefix_lstm$two_prefix_prob1

one_prefix_results = select(one_prefix_lstm, UID, pairID, linguistics_term, pred)
two_prefix_results = select(two_prefix_lstm, UID, pairID, linguistics_term, pred)
lm_results = select(lm_lstm, UID, pairID, linguistics_term, pred)

one_prefix_results$type = "one-prefix"
lm_results$type = "sentence"
two_prefix_results$type = "two-prefix"

broad_results = rbind(lm_results, one_prefix_results, two_prefix_results)

broad_breakdown = group_by(broad_results, UID, linguistics_term, type) %>% summarise(m_pred = mean(pred))
broad_breakdown

#head(one_prefix)
View(one_prefix_lstm)

colnames(one_prefix_lstm)


one_prefix_lstm$one_prefix1 = (one_prefix_lstm$prefix_logits1 + one_prefix_lstm$crit_logits1)
one_prefix_lstm$one_prefix2 = (one_prefix_lstm$prefix_logits2 + one_prefix_lstm$crit_logits2)

one_prefix_lstm$one_prefix_pred = (one_prefix_lstm$prefix_logits1 + one_prefix_lstm$crit_logits1) < 
  (one_prefix_lstm$prefix_logits2 + one_prefix_lstm$crit_logits2)
one_prefix_lstm$lm_pred = one_prefix_lstm$lm_prob1 < one_prefix_lstm$lm_prob2
one_prefix_lstm$append_pred = one_prefix_lstm$append_logits1 < one_prefix_lstm$append_logits2
one_prefix_lstm$crit_pred = one_prefix_lstm$crit_logits1 < one_prefix_lstm$crit_logits2
one_prefix_lstm$append_ent_pred = one_prefix_lstm$appen_entropy1 < one_prefix_lstm$appen_entropy2

one_prefix_lstm$linguistics_term = gsub("s-selection", "argument", one_prefix_lstm$linguistics_term)

one_prefix_lstm_breakdown = group_by(one_prefix_lstm, linguistics_term) %>% 
  summarise(m_lm_pred = mean(lm_pred),
              m_append_pred = mean(append_pred),
              m_crit_pred = mean(crit_pred),
              m_append_ent_pred = mean(append_ent_pred),
              m_one_prefix_pred = mean(one_prefix_pred))
#View(one_prefix_lstm_breakdown)

one_prefix_lstm$lm_pred_cat = as.factor(one_prefix_lstm$lm_pred)

ggplot(one_prefix_lstm, aes(x = (crit_logits2 - crit_logits1), y = (append_logits2 - append_logits1), color = lm_pred_cat)) + 
  geom_point(alpha = 0.2) + facet_wrap(~linguistics_term)

one_prefix_lstm_binding = filter(one_prefix_lstm, linguistics_term == 'binding')

ggplot(one_prefix_lstm_binding, aes(x = (lm_prob2 - lm_prob1), y = (append_logits2 - append_logits1), color = lm_pred_cat)) + 
  geom_point() + facet_wrap(~UID)

weird = filter(one_prefix_lstm, crit_logits2 == crit_logits1)
View(weird)

View(one_prefix_lstm_breakdown)

write_tsv(one_prefix_lstm_breakdown, "one_prefix_lstm_breakdown.tab")

one_prefix_grover = read_tsv('blimp_grover_oneprefix_peephole.tab')
#head(one_prefix)
View(one_prefix_grover)

colnames(one_prefix_grover)

one_prefix_grover$append_pred = one_prefix_grover$appen_logits1 < one_prefix_grover$appen_logits2
one_prefix_grover$crit_pred = one_prefix_grover$crit_logits1 < one_prefix_grover$crit_logits2

one_prefix_grover_breakdown = group_by(one_prefix_grover, UID) %>% summarise(
                                                                  m_append_pred = mean(append_pred),
                                                                  m_crit_pred = mean(crit_pred),
                                                                 )

one_prefix_grover_breakdown

two_prefix_lstm = read_tsv('blimp-lstm_twoprefix_peephole.tab')
View(two_prefix_lstm)

colnames(two_prefix_lstm)

two_prefix_lstm$two_prefix_pred = 
  (two_prefix_lstm$prefix_logits1 + two_prefix_lstm$crit_logits1) < 
  (two_prefix_lstm$prefix_logits2 + two_prefix_lstm$crit_logits2)
two_prefix_lstm$lm_pred = two_prefix_lstm$lm_prob1 < two_prefix_lstm$lm_prob2
two_prefix_lstm$append_pred = two_prefix_lstm$append_logits1 < two_prefix_lstm$append_logits2
two_prefix_lstm$crit_pred = two_prefix_lstm$crit_logits1 < two_prefix_lstm$crit_logits2
two_prefix_lstm$append_ent_pred = two_prefix_lstm$appen_entropy1 < two_prefix_lstm$appen_entropy2
two_prefix_lstm$prefix_pred = two_prefix_lstm$prefix_logits1 < two_prefix_lstm$prefix_logits2

two_prefix_lstm$linguistics_term = gsub("s-selection", "argument", one_prefix_lstm$linguistics_term)

two_prefix_lstm_breakdown = group_by(two_prefix_lstm, UID) %>% 
  summarise(m_lm_pred = mean(lm_pred),
            m_append_pred = mean(append_pred),
            m_crit_pred = mean(crit_pred),
            m_append_ent_pred = mean(append_ent_pred),
            m_prefix_pred = mean(prefix_pred),
            m_two_prefix_pred = mean(two_prefix_pred))

two_prefix_lstm_breakdown

write_tsv(two_prefix_lstm_breakdown, "two_prefix_lstm_breakdown.tab")
