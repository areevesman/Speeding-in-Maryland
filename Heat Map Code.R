library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(ggmap)
library(gridExtra)
library(grid)

BIGtraffic <- read.csv("C:/Users/adam/Documents/UCSB/Junior Year/PSTAT 174/Project/fullTrafficViolations.csv")
BIGtraffic$Description <- toupper(BIGtraffic$Description)

DF2 <- BIGtraffic[grep("SPEED", x = BIGtraffic$Description),]
df2 <- DF2[-grep("CONTEST", x = DF2$Description),]
df2 <- df2[-grep("LOW", x = df2$Description),]
df2 <- df2[-grep("BICYCL", x = df2$Description),]
df2 <- df2[-grep("CREAS", x = df2$Description),]
df2 <- df2[-grep("EMBLEM", x = df2$Description),]
df2 <- df2[-grep("SCTR", x = df2$Description),]
df2 <- df2[-grep("LAMPS", x = df2$Description),]
df2 <- df2[df2$Gender %in% c("M","F"),]
df2 <- df2[df2$Violation.Type != "ESERO",]
DF2 <- df2
DF3 <- DF2[str_sub(DF2$Date.Of.Stop, -4,-1) == "2016",]

mapBackground <- qmap("39.110290, -77.127074", zoom = 11, maptype = "roadmap")
legend.colors <- guides(colour = guide_legend(override.aes = list(alpha = 1)))

points <- geom_point(data = DF3, 
                     alpha = .05, 
                     aes(x = Longitude, 
                         y = Latitude, 
                         color = Gender))
totals <- scale_color_manual(values = c("green", "red"),
                             name="Gender",
                             breaks=c("F", "M"),
                             labels=c("Females: 12,705\n(54% Warnings)\n",
                                        "Males: 21,856\n(48% Warnings)\n"))
title <- ggtitle("Speeding Violations Issued in Montgomery County, MD in 2016")
center.title <- theme(plot.title = element_text(hjust = 0.5))
print(mapBackground + points + totals + legend.colors + title + center.title)
