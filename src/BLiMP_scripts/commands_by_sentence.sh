#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=20:00:00
#SBATCH --job-name=scil
#SBATCH --mail-type=END
##SBATCH --mail-user=sfw268@nyu.edu
#SBARCH --mem=8GB
#SBATCH --output=slurm_%j.out
#SBATCH --gres=gpu:1

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/adjunct_island --outfile ../results/blimp/txt_sentence/adjunct_island_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/anaphor_gender_agreement --outfile ../results/blimp/txt_sentence/anaphor_gender_agreement_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/animate_obj_passive --outfile ../results/blimp/txt_sentence/animate_obj_passive_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/animate_obj_trans --outfile ../results/blimp/txt_sentence/animate_obj_trans_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/animate_subj_passive --outfile ../results/blimp/txt_sentence/animate_subj_passive_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/animate_subj_trans --outfile ../results/blimp/txt_sentence/animate_subj_trans_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/causative --outfile ../results/blimp/txt_sentence/causative_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/complex_NP_island --outfile ../results/blimp/txt_sentence/complex_NP_island_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/coordinate_structure_constraint_complex_left_branch --outfile ../results/blimp/txt_sentence/coordinate_structure_constraint_complex_left_branch_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/coordinate_structure_constraint_object_extraction --outfile ../results/blimp/txt_sentence/coordinate_structure_constraint_object_extraction_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/coordinate_structure_constraint_subject_extraction --outfile ../results/blimp/txt_sentence/coordinate_structure_constraint_subject_extraction_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_1 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_2 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_irregular_1 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_irregular_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_irregular_2 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_irregular_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_with_adjective_1 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_with_adjective_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_with_adj_2 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_with_adj_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_with_adj_irregular_1 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_with_adj_irregular_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/determiner_noun_agreement_with_adj_irregular_2 --outfile ../results/blimp/txt_sentence/determiner_noun_agreement_with_adj_irregular_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/distractor_agreement_relational_noun --outfile ../results/blimp/txt_sentence/distractor_agreement_relational_noun_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/distractor_agreement_relative_clause --outfile ../results/blimp/txt_sentence/distractor_agreement_relative_clause_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/drop_argument --outfile ../results/blimp/txt_sentence/drop_argument_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/ellipsis_n_bar_1 --outfile ../results/blimp/txt_sentence/ellipsis_n_bar_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/ellipsis_n_bar_2 --outfile ../results/blimp/txt_sentence/ellipsis_n_bar_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/existential_there_object_raising --outfile ../results/blimp/txt_sentence/existential_there_object_raising_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/existential_there_quantifiers_1 --outfile ../results/blimp/txt_sentence/existential_there_quantifiers_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/existential_there_quantifiers_2 --outfile ../results/blimp/txt_sentence/existential_there_quantifiers_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/existential_there_subject_raising --outfile ../results/blimp/txt_sentence/existential_there_subject_raising_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/expletive_it_object_raising --outfile ../results/blimp/txt_sentence/expletive_it_object_raising_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/inchoative --outfile ../results/blimp/txt_sentence/inchoative_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/intransitive --outfile ../results/blimp/txt_sentence/intransitive_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/irregular_past_participle_adjectives --outfile ../results/blimp/txt_sentence/irregular_past_participle_adjectives_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/irregular_past_participle_verbs --outfile ../results/blimp/txt_sentence/irregular_past_participle_verbs_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/irregular_plural_subject_verb_agreement_1 --outfile ../results/blimp/txt_sentence/irregular_plural_subject_verb_agreement_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/irregular_plural_subject_verb_agreement_2 --outfile ../results/blimp/txt_sentence/irregular_plural_subject_verb_agreement_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/left_branch_island_echo_question --outfile ../results/blimp/txt_sentence/left_branch_island_echo_question_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/left_branch_island_simple_question --outfile ../results/blimp/txt_sentence/left_branch_island_simple_question_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/matrix_question_npi_licensor_present --outfile ../results/blimp/txt_sentence/matrix_question_npi_licensor_present_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/npi_present_1 --outfile ../results/blimp/txt_sentence/npi_present_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/npi_present_2 --outfile ../results/blimp/txt_sentence/npi_present_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/only_npi_licensor_present --outfile ../results/blimp/txt_sentence/only_npi_licensor_present_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/only_npi_scope --outfile ../results/blimp/txt_sentence/only_npi_scope_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/passive_1 --outfile ../results/blimp/txt_sentence/passive_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/passive_2 --outfile ../results/blimp/txt_sentence/passive_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_case_1 --outfile ../results/blimp/txt_sentence/principle_A_case_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_case_2 --outfile ../results/blimp/txt_sentence/principle_A_case_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_c_command --outfile ../results/blimp/txt_sentence/principle_A_c_command_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_domain_1 --outfile ../results/blimp/txt_sentence/principle_A_domain_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_domain_2 --outfile ../results/blimp/txt_sentence/principle_A_domain_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_domain_3 --outfile ../results/blimp/txt_sentence/principle_A_domain_3_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/principle_A_reconstruction --outfile ../results/blimp/txt_sentence/principle_A_reconstruction_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/regular_plural_subject_verb_agreement_1 --outfile ../results/blimp/txt_sentence/regular_plural_subject_verb_agreement_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/regular_plural_subject_verb_agreement_2 --outfile ../results/blimp/txt_sentence/regular_plural_subject_verb_agreement_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/sentential_negation_npi_licensor_present --outfile ../results/blimp/txt_sentence/sentential_negation_npi_licensor_present_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/sentential_negation_npi_scope --outfile ../results/blimp/txt_sentence/sentential_negation_npi_scope_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/sentential_subject_island --outfile ../results/blimp/txt_sentence/sentential_subject_island_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/simple_anaphor_number_agreement --outfile ../results/blimp/txt_sentence/simple_anaphor_number_agreement_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/superlative_quantifiers_1 --outfile ../results/blimp/txt_sentence/superlative_quantifiers_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/superlative_quantifiers_2 --outfile ../results/blimp/txt_sentence/superlative_quantifiers_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/tough_vs_raising_1 --outfile ../results/blimp/txt_sentence/tough_vs_raising_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/tough_vs_raising_2 --outfile ../results/blimp/txt_sentence/tough_vs_raising_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/transitive --outfile ../results/blimp/txt_sentence/transitive_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_island --outfile ../results/blimp/txt_sentence/wh_island_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_questions_object_gap --outfile ../results/blimp/txt_sentence/wh_questions_object_gap_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_questions_object_gap_long_distance --outfile ../results/blimp/txt_sentence/wh_questions_object_gap_long_distance_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_questions_subject_gap --outfile ../results/blimp/txt_sentence/wh_questions_subject_gap_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_questions_subject_gap_long_distance --outfile ../results/blimp/txt_sentence/wh_questions_subject_gap_long_distance_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_vs_that_no-gap --outfile ../results/blimp/txt_sentence/wh_vs_that_no-gap_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_vs_that_no_gap_long_distance --outfile ../results/blimp/txt_sentence/wh_vs_that_no_gap_long_distance_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_vs_that_with_gap --outfile ../results/blimp/txt_sentence/wh_vs_that_with_gap_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_sentence/wh_vs_that_with_gap_long_distance --outfile ../results/blimp/txt_sentence/wh_vs_that_with_gap_long_distance_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/anaphor_gender_agreement --outfile ../results/blimp/txt_one_prefix/anaphor_gender_agreement_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/animate_obj_trans --outfile ../results/blimp/txt_one_prefix/animate_obj_trans_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/animate_subj_passive --outfile ../results/blimp/txt_one_prefix/animate_subj_passive_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/determiner_noun_agreement_1 --outfile ../results/blimp/txt_one_prefix/determiner_noun_agreement_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/determiner_noun_agreement_irregular_1 --outfile ../results/blimp/txt_one_prefix/determiner_noun_agreement_irregular_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/determiner_noun_agreement_with_adjective_1 --outfile ../results/blimp/txt_one_prefix/determiner_noun_agreement_with_adjective_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/determiner_noun_agreement_with_adj_irregular_1 --outfile ../results/blimp/txt_one_prefix/determiner_noun_agreement_with_adj_irregular_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/distractor_agreement_relational_noun --outfile ../results/blimp/txt_one_prefix/distractor_agreement_relational_noun_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/distractor_agreement_relative_clause --outfile ../results/blimp/txt_one_prefix/distractor_agreement_relative_clause_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/irregular_past_participle_verbs --outfile ../results/blimp/txt_one_prefix/irregular_past_participle_verbs_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/irregular_plural_subject_verb_agreement_1 --outfile ../results/blimp/txt_one_prefix/irregular_plural_subject_verb_agreement_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/npi_present_1 --outfile ../results/blimp/txt_one_prefix/npi_present_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/npi_present_2 --outfile ../results/blimp/txt_one_prefix/npi_present_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/principle_A_case_1 --outfile ../results/blimp/txt_one_prefix/principle_A_case_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/principle_A_case_2 --outfile ../results/blimp/txt_one_prefix/principle_A_case_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/principle_A_c_command --outfile ../results/blimp/txt_one_prefix/principle_A_c_command_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/principle_A_domain_1 --outfile ../results/blimp/txt_one_prefix/principle_A_domain_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/principle_A_domain_2 --outfile ../results/blimp/txt_one_prefix/principle_A_domain_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/regular_plural_subject_verb_agreement_1 --outfile ../results/blimp/txt_one_prefix/regular_plural_subject_verb_agreement_1_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/simple_anaphor_number_agreement --outfile ../results/blimp/txt_one_prefix/simple_anaphor_number_agreement_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_one_prefix/wh_island --outfile ../results/blimp/txt_one_prefix/wh_island_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/animate_obj_passive --outfile ../results/blimp/txt_two_prefix/animate_obj_passive_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/animate_subj_trans --outfile ../results/blimp/txt_two_prefix/animate_subj_trans_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/coordinate_structure_constraint_complex_left_branch --outfile ../results/blimp/txt_two_prefix/coordinate_structure_constraint_complex_left_branch_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/determiner_noun_agreement_2 --outfile ../results/blimp/txt_two_prefix/determiner_noun_agreement_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/determiner_noun_agreement_irregular_2 --outfile ../results/blimp/txt_two_prefix/determiner_noun_agreement_irregular_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/determiner_noun_agreement_with_adj_2 --outfile ../results/blimp/txt_two_prefix/determiner_noun_agreement_with_adj_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/determiner_noun_agreement_with_adj_irregular_2 --outfile ../results/blimp/txt_two_prefix/determiner_noun_agreement_with_adj_irregular_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/existential_there_object_raising --outfile ../results/blimp/txt_two_prefix/existential_there_object_raising_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/expletive_it_object_raising --outfile ../results/blimp/txt_two_prefix/expletive_it_object_raising_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/irregular_past_participle_adjectives --outfile ../results/blimp/txt_two_prefix/irregular_past_participle_adjectives_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/irregular_plural_subject_verb_agreement_2 --outfile ../results/blimp/txt_two_prefix/irregular_plural_subject_verb_agreement_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/left_branch_island_echo_question --outfile ../results/blimp/txt_two_prefix/left_branch_island_echo_question_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/matrix_question_npi_licensor_present --outfile ../results/blimp/txt_two_prefix/matrix_question_npi_licensor_present_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/only_npi_licensor_present --outfile ../results/blimp/txt_two_prefix/only_npi_licensor_present_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/only_npi_scope --outfile ../results/blimp/txt_two_prefix/only_npi_scope_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/principle_A_domain_3 --outfile ../results/blimp/txt_two_prefix/principle_A_domain_3_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/regular_plural_subject_verb_agreement_2 --outfile ../results/blimp/txt_two_prefix/regular_plural_subject_verb_agreement_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/sentential_negation_npi_licensor_present --outfile ../results/blimp/txt_two_prefix/sentential_negation_npi_licensor_present_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/sentential_negation_npi_scope --outfile ../results/blimp/txt_two_prefix/sentential_negation_npi_scope_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/superlative_quantifiers_2 --outfile ../results/blimp/txt_two_prefix/superlative_quantifiers_2_output.tab

python language_models/evaluate_target_word_no_mask.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/blimp/txt_two_prefix/transitive --outfile ../results/blimp/txt_two_prefix/transitive_output.tab
