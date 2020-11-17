###############################################################################
#                                                                             #
#                           Ngonidzashe Mandiveyi                             #
#                           Data Analysis Using R                             #
#                              Final Project                                  #
#                           /Data Manipulation/                                      #
#                                                                             #
###############################################################################
# data_manipulation.R

# Now we convert into tidy text form. This concept is similar to tidy data.
# The idea is we want (1) words in rows[we could also have sentences or n-grams]
# (2) we want to remove stop words: these are words like "the", "to", "a" that 
# don't really add much to our text. We will use tidytext, dplyr, tidyr for this
# special cleaning process. We have already loaded these.

# First let's extract only the text.
just_txt <- clean_data1(raw_data)

# Get the stop words data frame into the work space
data(stop_words)

# Get another list of stop words specific to this analysis
specific_stopwords <- read.csv(paste(raw_dir, "specific_stopwords.csv", sep = ""))

# Convert to tidy text: one word-per-row
tidy_txt <- just_txt %>%
  # there is a column called text in tidy_txt
  unnest_tokens(word, text) %>%
  # Now remove the stop words
  anti_join(stop_words) %>%
  #Now remove the specific stop words
  anti_join(specific_stopwords)

# Get the count of each word
freq_data <- tidy_txt %>%
  dplyr::count(word, sort = T)

# Sentiment Analysis

# Get the bing sentiment lexicon into the work space
sent <- get_sentiments("bing")

# Extent the data frame: assign index numbers to the tweets
tidy_text_sentiments <- as_tibble(just_txt) %>%
  group_by(year) %>%
  #ungroup() %>%
  unnest_tokens(word, text) %>%
  inner_join(sent) %>%
  dplyr::count(year, index = tweet_number %% 200, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
