###############################################################################
#                                                                             #
#                           Ngonidzashe Mandiveyi                             #
#                           Data Analysis Using R                             #
#                              Final Project                                  #
#                               /Analysis/                                    #
#                                                                             #
###############################################################################
# analysis.R

# This is the script where all the analysis happens. First, I test the pre and
# post election data for correlation.


#==============================================================================
#                              /PEARSON'S R/

cor.test(data = pre_post_freq[pre_post_freq$year == "2017-2020",],
         ~ proportion + `2013-2016`)

#         Pearson's product-moment correlation
# 
# data:  proportion and 2013-2016
# t = 118.26, df = 9559, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.7624597 0.7787394
# sample estimates:
#       cor 
# 0.7707253 

#==============================================================================
#                             /TOPIC MODELING/

# First convert the data set into a document term matrix, we will use the tidy
# text library for this
# tidy_txt object in data_manipulation.R is a good starting point
data_doc_term_mtrx <- tidy_txt %>%
  dplyr::count(year, word) %>%
  dplyr::rename(document = year, term = word, count = n) %>%
  tidytext::cast_dtm(document, term, count)

# Use the Latent Dirichlet Allocation method
# This is the topic model
# 4 topics is random; I could also have done any random rumber
data_lda_method <- LDA(data_doc_term_mtrx, k = 4, control = list(seed = 1234))

# Analysis on the model
# First let's view the topics

model_topics <- tidytext::tidy(data_lda_method, matrix = "beta")

# Cleanup the data frame for visualization
most_frequent <- model_topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

# Let's visualize the most frequent terms
pdf(file = paste(results_dir,"models.pdf", sep = ""), width = 10, height = 10,
    title = "Topic Modeling")

most_frequent %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered()
dev.off()







