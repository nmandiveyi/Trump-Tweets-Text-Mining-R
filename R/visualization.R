###############################################################################
#                                                                             #
#                           Ngonidzashe Mandiveyi                             #
#                           Data Analysis Using R                             #
#                              Final Project                                  #
#                            /Visualization/                                  #
#                                                                             #
###############################################################################
# visualization.R

#==============================================================================
#                        /BAR PLOT FOR MOST USED WORDS/

# Plot the words with frequencies greater than 800

# Set up a graphical device to plot the graph as a pdf

pdf(file = paste(results_dir,"most_used.pdf", sep = ""), width = 10, height = 6, title = "Word count in book")

freq_data %>%
  filter(n > 1000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  labs(x = NULL, y = "Count", title = "Most used words in Trump'S tweets (2014-2020)")

dev.off()

pdf(file = paste(results_dir,"word_cloud.pdf", sep = ""), width = 10, height = 10, title = "Word count in book")

# Plot a word cloud for tidy text

freq_data %>% 
  with(wordcloud(word, n, max.words = 1000))

dev.off()

# Sentiment Analysis


