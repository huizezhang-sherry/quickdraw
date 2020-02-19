## code to prepare `category` dataset goes here

categories <- readLines("data-raw/categories.txt")

usethis::use_data(categories)

