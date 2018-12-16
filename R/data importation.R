
#Data importation
SciViews::R
(biometry <- read_csv("https://docs.google.com/spreadsheets/d/1UfpZvx1_nd7d10vIMAfGVZ1vWyIuzeiKxPL0jfkNSQM/export?format=csv", locale = locale(decimal_mark = ",")))

biometry %>.%
  filter(., ! is.na(masse_corr)) -> biometry
filter(., ! is.na(age)) -> biometry
biometry$genre <- as.factor(biometry$genre)
biometry$hainaut <- as.factor(biometry$hainaut)
biometry$acti_profession <- as.factor(biometry$acti_profession)

biometry <- mutate(biometry, IMC = masse_corr/taille^2) %>.%
  mutate(., surpoid = IMC >= 25 & IMC < 30, obese = IMC> 30, normal = IMC <25 & IMC >= 18.5 , souspoid = IMC < 18.5)%>.%
gather(.,
       souspoid, normal, obese, surpoid, key = "sequences", value = "rapport_imc")%>.%

  filter (., rapport_imc != FALSE)

biometry$age_rec <- cut(biometry$age, include.lowest=FALSE,  right=TRUE,
                        breaks=c(0, 20, 40, 60, 110))


biometry <- mutate(biometry, jeune = age <= 25 , adulte = age > 25 & age <= 60 , agé = age > 60)%>.%
gather(.,jeune,adulte,agé, key = "tranche_d_age",value = "categorie_age")%>.%
filter (., categorie_age != FALSE)


visdat::vis_dat(biometry)
head(biometry)

write$rds(biometry, file = "./data/biometry.rds", compress = "gz")

