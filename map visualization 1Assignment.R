library(ggplot2)  
library(maps) 

library(dplyr) 

MainStates <- map_data("state")

# read the state population data
StatePopulation <- read.csv("https://raw.githubusercontent.com/ds4stats/r-tutorials/master/intro-maps/data/StatePopulation.csv", as.is = TRUE)
str(MainStates)
str(StatePopulation)

ggplot() + 
  geom_polygon( data=MainStates, aes(x=long, y=lat, group=group),
                color="black", fill="lightblue" )

MergedStates <- inner_join(MainStates, StatePopulation, by = "region")

p <- ggplot()
p <- p + geom_polygon( data=MergedStates, 
                       aes(x=long, y=lat, group=group, fill = population/1000000), 
                       color="white", size = 0.2) 
p
p <- p + scale_fill_continuous(name="Population(millions)", 
                               low = "lightgreen", high = "darkgreen",limits = c(0,40), 
                               breaks=c(5,10,15,20,25,30,35), na.value = "grey50") +
  
  labs(title="State Population in the Mainland United States")
p

p <- p + guides(fill = guide_colorbar(barwidth = 0.5, barheight = 10, 
                                      label.theme = element_text(color = "green", size =10, angle = 45)))
p

AllCounty <- map_data("county")
ggplot() + geom_polygon( data=AllCounty, aes(x=long, y=lat, group=group),
                         color="darkblue", fill="lightblue", size = .1 ) +
  
  geom_polygon( data=MainStates, aes(x=long, y=lat, group=group),
                color="black", fill="lightblue",  size = 1, alpha = .3)

p <- p + geom_point(data=us.cities, aes(x=long, y=lat, size = pop)) + 
  
  scale_size(name="Population")

us.cities2=arrange(us.cities, pop)
tail(us.cities2)

#plot all states with ggplot
MainCities <- filter(us.cities, long>=-130)
# str(us.cities)
# str(MainCities)

g <- ggplot()
g <- g + geom_polygon( data=MergedStates, 
                       aes(x=long, y=lat, group=group, fill = population/1000000), 
                       color="black", size = 0.2) + 
  
  scale_fill_continuous(name="State Population", low = "lightblue", 
                        high = "darkblue",limits = c(0,40), breaks=c(5,10,15,20,25,30,35), 
                        na.value = "grey50") +
  
  labs(title="Population (in millions) in the Mainland United States")

g <- g + geom_point(data=MainCities, aes(x=long, y=lat, size = pop/1000000), 
                    color = "gold", alpha = .5) + scale_size(name="City Population")
g

# Zoom into a particular region of the plot
g  <- g + coord_cartesian(xlim=c(-80, -65), ylim = c(38, 46))
g

NewStates <- filter(MainStates,region ==  "new york" | region ==
                      "vermont" | region ==  "new hampshire" | region ==
                      "massachusetts" | region ==  "rhode island" | 
                      region ==  "connecticut" )

g <- g + geom_point(data=MainCities, aes(x=long, y=lat, 
                                         size = pop/1000000, color=factor(capital), shape = factor(capital)), 
                    alpha = .5) + 
  
  scale_size(name="City Population")

