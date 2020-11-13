###############################################################################
#                                                                             #
#                           Ngonidzashe Mandiveyi                             #
#                           Data Analysis Using R                             #
#                              Final Project                                  #
#                                 /Main/                                      #
#                                                                             #
###############################################################################
# main.R

# This is the main script for my project. The project is analyzes text from 
# Donald Trump's twitter handle for patterns. Data for this project will be
# fetched from https://www.thetrumparchive.com/. This application will be 
# reproducible. The user will be prompted to provide the year from when they 
# wish the analysis to begin.

# =============================================================================
# R version 3.6.3 (2020-02-29)
#
# =============================================================================
#                                   /NOTES/
#
#
#
# =============================================================================
#                             /GLOBAL VARIABLES/

working_dir <- getwd() 

# =============================================================================
#                                /LIBRARIES/

# Install the important packages
# The required packages
Packages <- c("rtweet", "tidytext", "stringr", "textdata", "dplyr", "tidyr", 
              "ggplot2", "pacman", "jsonlite", "svDialogs", "plyr")

# install if not already installed
if (any(!Packages %in% installed.packages())) {
  install.packages(Packages[!Packages %in% installed.packages()])
}


# Load the packages to our current workspace
pacman::p_load(rtweet, tidytext, stringr, textdata, dplyr, tidyr, ggplot2,
               jsonlite, svDialogs, plyr)

# =============================================================================
#                            /FOLDER MANAGMENT/

# Set up the structure of the project. We will have three folders:
# Raw_data, Clean_data, and Data_Visualizatio. The names are 
# self-explanatory. 
folders_vector <- c("Raw_Data","Clean_Data", "Data_Visualization")

# Make the folders in the folder_vector if they do not already exist
for(i in 1:length(folders_vector)){ 
  if(file.exists(folders_vector[i]) == FALSE){
    dir.create(folders_vector[i])
  } 
}

# Set up R objects to keep the paths to the above folders as strings
raw_dir <- paste(working_dir, "/", folders_vector[1], "/", sep = "")
clean_dir <- paste(working_dir, "/", folders_vector[2], "/", sep = "")
results_dir <- paste(working_dir, "/", folders_vector[3], "/", sep = "")

# =============================================================================
#                               /RUN SCRIPTS/
# This is the script that contains the new functions that I have defined. Refer 
# to functions.R.
source("R/functions.R")

#==============================================================================
#                           /GET THE DATA READY/

# First things first. Let's download the data and save it locally as a csv file.
# For us to do this, we need to make a list of the years that we are analyzing.
# We will need INPUT from the user for the year to start analysis

# Get a vector containing the years (as integers) over which we are trying to
# analyze
years_list <- user_get_years()

# Download the data for these year, return it to use as a list of data frames
# Here, we get the data as a .json file
raw_raw <- get_multiple(years_list)

# Now combine the list of data frames into one
raw_data <- clean_data0(raw_raw)

# Save this into the raw folder. We won't use this file at all in the analysis,
# but it will help the user get what's going on,
write.csv(raw_data, paste(raw_dir,"Trump_twitter_raw.csv", sep = ""), 
          row.names = FALSE)

# Now we convert into tidy text form. This concept is similar to tidy data.
# The idea is we want (1) words in rows[we could also have sentences or n-grams]
# (2) we want to remove stop words: these are words like "the", "to", "a" that 
# don't really add much to our text. We will use tidytext, dplyr, tidyr for this
# special cleaning process. We have already loaded these.

# First let's extract only the text.
just_txt <- clean_data(raw_data)

# Get the stop words data frame into the work space
data(stop_words)

# Convert to tidy text: one word-per-row
tidy_txt <- just_txt %>%
  # there is a column called text in tidy_txt
  unnest_tokens(word, text) %>%
  # Now remove the stop words
  anti_join(stop_words)

# Get the count of each word
freq_data <- tidy_txt %>%
  dplyr::count(word, sort = T)

# ================================ END ========================================
















































































