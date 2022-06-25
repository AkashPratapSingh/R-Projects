library(tidyverse)
View(starwars)
starwars%>% 
  select(name, gender, hair_color, height)%>%
View()
starwars%>% 
  select(name, gender, hair_color, height)%>%
filter(!complete.cases(.));
install.packages("mice")
library(mice)
md.pattern(starwars)
starwars%>% 
  select(name, gender, hair_color, height)%>%
na.omit() %>%
  View();
#This is deleting all row with missing Date

#2. Deleting row in a specific variable
starwars%>% 
  select(name, gender, hair_color, height)%>%

drop_na(height)%>%
  view()

#replacing value with none in column gender

starwars%>% 
  select(name, gender, hair_color, height)%>%
  
  drop_na(height)%>%
mutate(gender=replace_na(gender, "none"))%>%
  view()

unique(starwars$hair_color)

starwars%>% 
  select(name, gender, hair_color, height)%>%
  mutate(hair_color =na_if(hair_color, "unknown"))%>%
filter(is.na(hair_color))%>%
View()

mean(starwars$height, na.rm = TRUE)

  
  
 
