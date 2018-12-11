#Data importation
SciViews::R
(biometry <- read_csv("https://docs.google.com/spreadsheets/d/1UfpZvx1_nd7d10vIMAfGVZ1vWyIuzeiKxPL0jfkNSQM/export?format=csv", locale = locale(decimal_mark = ",")))

biometry %>.%
  filter(., ! is.na(masse_corr)) -> biometry

biometry$genre <- as.factor(biometry$genre)
biometry$hainaut <- as.factor(biometry$hainaut)
visdat::vis_dat(biometry)


write$rds(biometry, file = "./data/biometry.rds", compress = "gz")
