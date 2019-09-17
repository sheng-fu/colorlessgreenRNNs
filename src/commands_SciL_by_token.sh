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

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/anaphor_reconstruction --outfile ../data/sent_pair/txt_sentence/anaphor_reconstruction_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/complex_left_branch_echoQ --outfile ../data/sent_pair/txt_sentence/complex_left_branch_echoQ_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/complex_left_branch_simpleQ --outfile ../data/sent_pair/txt_sentence/complex_left_branch_simpleQ_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/csc_obj_extraction --outfile ../data/sent_pair/txt_sentence/csc_obj_extraction_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/csc_subj_extraction --outfile ../data/sent_pair/txt_sentence/csc_subj_extraction_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/determiner_noun_agreement_1 --outfile ../data/sent_pair/txt_sentence/determiner_noun_agreement_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/determiner_noun_agreement_2 --outfile ../data/sent_pair/txt_sentence/determiner_noun_agreement_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/determiner_noun_agreement_with_adj_1 --outfile ../data/sent_pair/txt_sentence/determiner_noun_agreement_with_adj_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/determiner_noun_agreement_with_adj_2 --outfile ../data/sent_pair/txt_sentence/determiner_noun_agreement_with_adj_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/existential_there_quantifiers_1 --outfile ../data/sent_pair/txt_sentence/existential_there_quantifiers_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/existential_there_quantifiers_2 --outfile ../data/sent_pair/txt_sentence/existential_there_quantifiers_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/irregular_plural_subj_v_agreement_1 --outfile ../data/sent_pair/txt_sentence/irregular_plural_subj_v_agreement_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/irregular_plural_subj_v_agreement_2 --outfile ../data/sent_pair/txt_sentence/irregular_plural_subj_v_agreement_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/matrix_question_npi_licensor_present --outfile ../data/sent_pair/txt_sentence/matrix_question_npi_licensor_present_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/npi_present_1 --outfile ../data/sent_pair/txt_sentence/npi_present_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/npi_present_2 --outfile ../data/sent_pair/txt_sentence/npi_present_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/only_npi_licensor_present --outfile ../data/sent_pair/txt_sentence/only_npi_licensor_present_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/only_npi_scope --outfile ../data/sent_pair/txt_sentence/only_npi_scope_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/principle_A_case --outfile ../data/sent_pair/txt_sentence/principle_A_case_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/principle_A_c_command --outfile ../data/sent_pair/txt_sentence/principle_A_c_command_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/principle_A_domain --outfile ../data/sent_pair/txt_sentence/principle_A_domain_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/principle_A_domain2 --outfile ../data/sent_pair/txt_sentence/principle_A_domain2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/principle_A_domain3 --outfile ../data/sent_pair/txt_sentence/principle_A_domain3_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/regular_plural_subj_v_agreement_1 --outfile ../data/sent_pair/txt_sentence/regular_plural_subj_v_agreement_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/regular_plural_subj_v_agreement_2 --outfile ../data/sent_pair/txt_sentence/regular_plural_subj_v_agreement_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/sentential_negation_npi_licensor_present --outfile ../data/sent_pair/txt_sentence/sentential_negation_npi_licensor_present_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/sentential_negation_npi_scope --outfile ../data/sent_pair/txt_sentence/sentential_negation_npi_scope_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/sentential_subject --outfile ../data/sent_pair/txt_sentence/sentential_subject_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/simple_anaphor_gender_agreement --outfile ../data/sent_pair/txt_sentence/simple_anaphor_gender_agreement_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/simple_anaphor_number_agreement --outfile ../data/sent_pair/txt_sentence/simple_anaphor_number_agreement_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/subject_island --outfile ../data/sent_pair/txt_sentence/subject_island_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/superlative_quantifiers_1 --outfile ../data/sent_pair/txt_sentence/superlative_quantifiers_1_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/superlative_quantifiers_2 --outfile ../data/sent_pair/txt_sentence/superlative_quantifiers_2_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/that_trace_embedded --outfile ../data/sent_pair/txt_sentence/that_trace_embedded_output_by_token.tab

python language_models/evaluate_target_word_no_mask_per_word.py --data ../data/lm/English/ --checkpoint ../models/hidden650_batch128_dropout0.2_lr20.0.pt  --suffix best_model --cuda --path ../data/sent_pair/txt_sentence/that_trace_matrix --outfile ../data/sent_pair/txt_sentence/that_trace_matrix_output_by_token.tab

