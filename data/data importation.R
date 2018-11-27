#Data importation
SciViews::R
(biometry <- read_csv("https://docs.google.com/spreadsheets/d/1UfpZvx1_nd7d10vIMAfGVZ1vWyIuzeiKxPL0jfkNSQM/export?format=csv", locale = locale(decimal_mark = ",")))



write$rds(biometry, file = "./data/biometry.rds", compress = "gz")
