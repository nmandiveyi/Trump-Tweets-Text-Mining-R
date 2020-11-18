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
# This program downloads large files of data. To facilitate smooth running of
# every piece, all scripts are run at once here in main.R
#
# Folder Structure
# The folder names are self explanatory. Open them for more information.
# Main Project folder
#         main.R
#         R
#             data_manipulation.R
#             functions.R
#             visualization.R
#             analysis.R
#         1.Raw Data
#             Trump_twitter_raw.csv
#         2.Clean Data
#             just_txt.csv
#             pre_post_freq.csv
#         3.Data Visualization
#             prepost_comparison.pdf
#             models.pdf
#             sentiment_analysis.pdf
#             most_used.pdf
#             word_cloud.pdf
#
# You will be prompted to enter a a year you want the analysis to start,
# please press enter if you are okay with the default value of 2013
# Otherwise, enter the year you wish the analysis to start
#
# =============================================================================
#                             /GLOBAL VARIABLES/
# Define the main directory so that all programs can access it.
working_dir <- getwd() 
# =============================================================================
#                                /LIBRARIES/

# Install the important packages if not already installed
# The required packages, they are actually all required
Packages <- c("rtweet", "tidytext", "stringr", "textdata", "dplyr", "tidyr", 
              "ggplot2", "pacman", "jsonlite", "svDialogs", "plyr", "wordcloud", 
              "scales", "topicmodels", "reshape2")

# install if not already installed
if (any(!Packages %in% installed.packages())) {
  install.packages(Packages[!Packages %in% installed.packages()])
}


# Load the packages to our current work space
pacman::p_load(rtweet, tidytext, stringr, textdata, dplyr, tidyr, ggplot2,
               jsonlite, svDialogs, plyr, wordcloud, scales, topicmodels, reshape2)

# =============================================================================
#                            /FOLDER MANAGMENT/

# Set up the structure of the project. We will have three folders:
# Raw_data, Clean_data, and Data_Visualizatio. The names are 
# self-explanatory. 
folders_vector <- c("1.Raw Data","2.Clean Data", "3.Data Visualization")

# Make the folders in the folder_vector if they do not already exist
for(i in 1:length(folders_vector)){ 
  if(file.exists(folders_vector[i]) == F){
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
          row.names = F)

# =============================================================================
#                        /RUN SCRIPTS OTHER SCRIPTS/
# This is the script that contains the all the data manipulation. Refer 
# to data_manipulation.R in the R folder.
source("R/data_manipulation.R")

#This is the script that does all the analysis with the clean data
# Refer to the R folder
source("R/analysis.R")

# This is the script that contains the all the data visualization. Refer 
# to visualization.R in the R folder.
source("R/visualization.R")

# ================================ END ========================================










































































