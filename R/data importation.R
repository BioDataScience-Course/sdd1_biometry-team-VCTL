
#Data importation
SciViews::R
(biometry <- read_csv("https://docs.google.com/spreadsheets/d/1UfpZvx1_nd7d10vIMAfGVZ1vWyIuzeiKxPL0jfkNSQM/export?format=csv", locale = locale(decimal_mark = ",")))

biometry %>.%
  filter(., ! is.na(masse_corr)) -> biometry
filter(., ! is.na(age)) -> biometry
biometry$genre <- as.factor(biometry$genre)
biometry$hainaut <- as.factor(biometry$hainaut)
biometry$acti_profession <- as.factor(biometry$acti_profession)

mutate(biometry, IMC = masse_corr/taille^2) %>.%
  mutate(.,IMC_RAP = case_when( IMC >= 25 & IMC < 30 ~ "surpoid",
                                IMC> 30  ~ "obese",
                                IMC <25 & IMC >= 18.5 ~ "normal",
                                IMC < 18.5 ~ "souspoid" ,
                                TRUE ~ as.character(IMC)
  )) ->biometry
biometry %>.%
  filter(., ! is.na(IMC_RAP)) -> biometry

biometry$age_rec <- cut(biometry$age, include.lowest=FALSE,  right=TRUE,
                        breaks=c(0, 20, 40, 60, 110))


visdat::vis_dat(biometry)
head(biometry)

write$rds(biometry, file = "./data/biometry.rds", compress = "gz")

