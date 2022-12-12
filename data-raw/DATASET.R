# clean scale data
library(utils)
library(caret)
library(magrittr)
library(dplyr)
library(stringr)
load("C:/yangting/R/programming tool/Spotify/data-raw/Spotify_raw.rda")

# change column name and genres to capital letters
colnames(Spotify) <- str_to_title(colnames(Spotify))
Spotify$Track_genre <- str_to_title(Spotify$Track_genre)

nume_col <- Spotify %>%
  select(5,6,8,9,11,13,14,15,16,17,18)
cate_col <- Spotify %>%
  select(1,2,3,4,7,10,12,19,20)

norm_data <- preProcess(nume_col,method=c("range"),rangeBounds = c(0, 10))
nume_col <- predict(norm_data,as.data.frame(nume_col))

Spotify <- cate_col %>%
  cbind(nume_col)
# delete the rows that are duplicated track
Spotify <- Spotify[!duplicated(Spotify[4:20]),]

usethis::use_data(Spotify, compress = "xz",overwrite = TRUE)

