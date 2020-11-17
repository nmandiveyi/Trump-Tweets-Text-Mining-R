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

pdf(file = paste(results_dir,"most_used.pdf", sep = ""), width = 10, height = 6)

freq_data %>%
  filter(n > 1000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, NA)) +
  geom_col(fill = "lightskyblue2", color = "black") +
  labs(x = "Count", y = NULL, 
       title = "Most used words in Trump's tweets (2014-2020)") +
  theme_light()

dev.off()

#==============================================================================
#                     /SENTIMENT ANALYSIS VISUALIZATION/
# Sentiment Analysis
pdf(file = paste(results_dir,"sentiment_analysis.pdf", sep = ""), width = 8.5, 
    height = 11, title = "Word count in book")

ggplot(tidy_text_sentiments, aes(index, sentiment, fill = year)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~year, ncol = 2, scales = "free_x") +
  theme_light()

dev.off()

#==============================================================================
#                              /PLOT A WORD CLOUD/
pdf(file = paste(results_dir,"word_cloud.pdf", sep = ""), width = 10, height = 10,
    title = "Word count in book")

# Plot a word cloud for tidy text
freq_data %>% 
  with(wordcloud(word, n, max.words = 500, colors = "lightskyblue"))

dev.off()

#==============================================================================
# Create a plot to compare the use of words pre and post election

ggplot(pre_post_freq, aes(x = proportion, y = `2013-2016`, 
                        color = abs(`2013-2016` - proportion))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), 
                       low = "darkslategray4", high = "gray75") +
  labs(y = "2013-2016", x = NULL)


