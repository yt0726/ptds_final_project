
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Spotify

<!-- badges: start -->
<!-- badges: end -->

The goal of Spotify is to …

## Installation

You can install the development version of Spotify from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ptds2022/final-project-group-a-1")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Spotify)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
example <- spotify_appinfo(genres="Funk",
                features=c("Danceability","Energy","Loudness","Speechiness","Liveness"),
                levels = c(9,8,5,4,7))
knitr::kable(example$result)
```

|     | Artists                                                           | Track_name                            | Track_genre | Danceability | Energy | Loudness | Speechiness | Liveness |  score_1 | score_2 |  score_3 |  score_4 | score_5 | final_score |
|:----|:------------------------------------------------------------------|:--------------------------------------|:------------|-------------:|-------:|---------:|------------:|---------:|---------:|--------:|---------:|---------:|--------:|------------:|
| 437 | DJ Ghost Floripa                                                  | Mega Funk Reload Vuk Vuk              | Funk        |     9.106599 |   8.13 | 8.175647 |   1.5440415 |     2.36 | 9.893401 |    9.87 | 6.824353 | 7.544041 |    5.36 |    1.657559 |
| 707 | Wilson Pickett                                                    | Let Me Know                           | Funk        |     8.395939 |   7.29 | 7.289089 |   1.3782383 |     6.35 | 9.395939 |    9.29 | 7.710911 | 7.378238 |    9.35 |    1.650778 |
| 269 | James Brown                                                       | Get Up Offa That Thing                | Funk        |     8.395939 |   7.76 | 7.776483 |   3.6787565 |     5.45 | 9.395939 |    9.76 | 7.223517 | 9.678757 |    8.45 |    1.650557 |
| 805 | Snoop Dogg;The Doors                                              | Riders On The Storm - Fredwreck Remix | Funk        |     8.913706 |   7.86 | 8.186375 |   1.5751295 |     1.22 | 9.913706 |    9.86 | 6.813625 | 7.575130 |    4.22 |    1.647530 |
| 265 | George Benson                                                     | Give Me the Night (Single Version)    | Funk        |     8.548223 |   8.01 | 7.976250 |   0.6331606 |     3.87 | 9.548223 |    9.99 | 7.023750 | 6.633161 |    6.87 |    1.647101 |
| 464 | Snoop Dogg;Surjeet Singh;Akshay Kumar;Kuldeep Ral;Manjeet Ral;RDB | Singh Is Kinng - Title Song           | Funk        |     9.035533 |   8.13 | 8.337125 |   0.7761658 |     1.24 | 9.964467 |    9.87 | 6.662875 | 6.776166 |    4.24 |    1.647085 |
| 294 | Kyan                                                              | Mandrake                              | Funk        |     8.974619 |   7.70 | 8.328617 |   2.3937824 |     1.07 | 9.974619 |    9.70 | 6.671383 | 8.393782 |    4.07 |    1.643091 |
| 103 | 2Pac;Big Syke                                                     | All Eyez On Me (ft. Big Syke)         | Funk        |     8.852792 |   7.23 | 8.057821 |   2.5595855 |     3.27 | 9.852792 |    9.23 | 6.942179 | 8.559586 |    6.27 |    1.642564 |
| 688 | MC Marks;Mc Davi;Mc Don Juan                                      | Ela Tá Tá Tá                          | Funk        |     8.903553 |   7.21 | 7.970886 |   0.4818653 |     2.85 | 9.903553 |    9.21 | 7.029114 | 6.481865 |    5.85 |    1.641093 |
| 625 | MC Teteu;JC NO BEAT;DJ F7                                         | Ta Com Saudade de Mim                 | Funk        |     8.883249 |   7.75 | 8.106653 |   0.5709845 |     1.07 | 9.883249 |    9.75 | 6.893347 | 6.570984 |    4.07 |    1.638967 |

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.
