# visualization.R

#==============================================================================
#                        /BAR PLOT FOR MOST USED WORDS/

# Plot the words with frequencies greater than 800

# Set up a graphical device to plot the graph as a pdf
# Start a graphical device to plot
pdf(file = paste(results_dir,"most_used.pdf", sep = ""), width = 10, height = 6)

freq_data %>%
  filter(n > 1000) %>%  # Only plot words with frequency greater than 1000
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, NA)) +
  geom_col(color = "aquamarine4", fill = "aquamarine4") +
  labs(x = "Count", y = NULL, 
       title = NULL) +
  theme_light() +
  theme(text = element_text(size = 15))

# Close the device and save the plot as a pdf
dev.off()

#==============================================================================
#                     /SENTIMENT ANALYSIS VISUALIZATION/
# Sentiment Analysis
# Start a graphical device to plot
pdf(file = paste(results_dir,"sentiment_analysis.pdf", sep = ""), width = 8.5, 
    height = 11, title = "Word count in book")

ggplot(tidy_text_sentiments, aes(index, sentiment, fill = year)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~year, ncol = 2, scales = "free_x") +
  theme_light() +
  theme(text = element_text(size = 15))

dev.off()

#==============================================================================
#                              /PLOT A WORD CLOUD/
# Start a graphical device to plot
pdf(file = paste(results_dir,"word_cloud.pdf", sep = ""), width = 10, height = 10,
    title = "Word count in book")

# Plot a word cloud for tidy text
freq_data %>% 
  with(wordcloud(word, n, max.words = 500, colors = "darkslategray4"))

# Close the device and save the plot as a pdf
dev.off()

#==============================================================================
#                            /PRE-POST COMPARISON/
# Create a plot to compare the use of words pre and post election

# Start a graphical device to plot
pdf(file = paste(results_dir,"prepost_comparison.pdf", sep = ""), width = 8.5, 
    height = 6, title = "Pre post Comarizon")

ggplot(pre_post_freq, aes(x = proportion, y = `2013-2016`, 
                        color = abs(`2013-2016` - proportion))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  # correct the values on the axes 
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), 
                       low = "slategray4", high = "snow2") +
  theme_light() +
  theme(legend.title = element_blank(), text = element_text(size = 15)) +
  labs(y = "2013-2016", x = "2017-2020")

# Close the device and save the plot as a pdf
dev.off()
#==============================================================================
#                         /MOST FREQUENT IN TOPICS/
# Let's visualize the most frequent terms
# Start a graphical device to plot
pdf(file = paste(results_dir,"models.pdf", sep = ""), width = 10, height = 10,
    title = "Topic Modeling")

most_frequent %>%
  mutate(term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered() +
  theme(text = element_text(size = 15))

# Close the device and save the plot as a pdf
dev.off()

# ================================ END ========================================