###############################################################################
#                                                                             #
#                           Ngonidzashe Mandiveyi                             #
#                           Data Analysis Using R                             #
#                              Final Project                                  #
#                              /Functions/                                    #
#                                                                             #
###############################################################################
# functions.R
# Define all the new functions for the project

#==============================================================================
# Define a function that creates a list of years from a given year to date. For
# example, if the given year is 2015, and the current year is 2020, the function
# should return the vector c(2015, 2016, 2017, 2018, 2019, 2020)

user_get_years <- function(){
  # Here, prompt the user to give the year, we want the analysis to begin from
  year <- as.integer(dlgInput("Enter the year you wish analysis to start:", "2014")$res)
  # make a vector containing the years as intergers
  years <- seq(year, 
               as.integer(format(Sys.Date(), "%Y")))
  return(years)
}

#==============================================================================
# Define a function that returns a vector containing urls of interest

# make a vector containing the links for data for each yeari in the vector 
# years


#==============================================================================
get_multiple <- function(years_lst){
  # define a function that returns a list of urls to the data we want
  make_url <- function(years){
    url_list <- c()
    for (yr in years){
      urls = paste0(
        "http://trumptwitterarchive.com/",
        "data/realdonaldtrump/",
        yr,
        ".json")
      url_list <- append(url_list, urls, after = length(url_list))
    }
    return(url_list)
  }
  # Get the list of urls
  url_list = make_url(years_lst)
  # Return a list of data frames from each year
  big_data <- lapply(url_list, get_web_data) 
  return(big_data)
}

#==============================================================================
# Define a function that fetches data from a website given the url
get_web_data <- function(proj_url){
  # Download the data as a .json file
  d.t <- httr::GET(proj_url) # Json file
  # Decode the data using UTF-8 encoding system
  dt_content <- httr::content(d.t, "text", encoding = "UTF-8")
  # Convert from the Json format
  from_json <- jsonlite::fromJSON(dt_content)
  return(from_json)
}

#==============================================================================

# Define a function that collects more data for more that one year. This 
# function Will build on get_web_data above. 

# Define a function that cleans the data. This functions works for the way the 
# the data is structured at https://www.thetrumparchive.com/. The function 
# might need revision in the future

# Tweet downloaded form https://www.thetrumparchive.com/ come with the tweet 
# itself plus around 80 other variables, but for our text analysis, we only need 
# the tweet. So by clean, I mean select for the tweet + only @Donald Trump's 
# tweets the return value will be a data frame containing only the text 
# attribute of tweets
clean_data0 <- function(input_data){
  # Check if input_data is a list. If so, combine it into a data frame
  if (is.list(input_data)){
    dt <- lapply(input_data, tibble::as.tibble)
    dt <- rbind.fill(dt)
  }
  return(dt)
}
clean_data1 <- function(data){
  # extract the text from data
  text = data$text
  # Extract the time stamp
  year = data$created_at
  #make a new data frame containing only these two column
  clean_df = data.frame(year, text) 
  
  clean_df = clean_df %>%
    dplyr::mutate(
      tweet_number = row_number(),
      year = as.integer(substring(year, 26)))
  
  return(clean_df)
}


