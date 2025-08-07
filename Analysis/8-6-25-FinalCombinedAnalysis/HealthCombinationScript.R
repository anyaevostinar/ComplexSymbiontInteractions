require(ggplot2)
#install.packages("viridis")
library(viridis)
library(scales)

#Set your working directory to the Analysis folder for your project
#Read in the data

mutualist_data <- read.table("../8-4-25-Mutualist0.65Refactored/complete_munged_basic.dat", h=T)
mutualist_data2<- read.table("../8-4-25-Mutualist0.65Refactored/complete_munged_basic2.dat", h=T)

combined_mutu_data <- rbind(mutualist_data, mutualist_data2)
combined_mutu_data[2] <- data.frame(lapply(combined_mutu_data[2], function(x) {gsub("MOI0.0", "No Symbionts", x)}))
combined_mutu_data[2] <- data.frame(lapply(combined_mutu_data[2], function(x) {gsub("MOI1.0", "Mutualists", x)}))

parasite_data <- read.table("../8-4-25-Parasites500k/munged_basic.dat", h=T)
parasite_data2 <- read.table("../8-4-25-Parasites500k/munged_basic.dat", h=T)

combined_para_data <- rbind(parasite_data, parasite_data2)
combined_para_data[2] <- data.frame(lapply(combined_para_data[2], function(x) {gsub("MOI0.0", "No Symbionts", x)}))
combined_para_data[2] <- data.frame(lapply(combined_para_data[2], function(x) {gsub("MOI1.0", "Parasites", x)}))  
para_only_sym <- subset(combined_para_data, treatment == "Parasites")

initial_data <- rbind(combined_mutu_data, para_only_sym)
initial_data$task <- factor(initial_data$task, levels=c("NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("_", " ", x)}))

final_update <- subset(initial_data, update == "500000")
 host_data <- subset(final_update, partner == "Host")


#regular box plot
ggplot(data=host_data, aes(x=treatment, y=count, color=treatment)) + geom_boxplot(alpha=0.5, outlier.size=1) + ylab("Boolean Logic Operation Count Final Update") + xlab("Mutualists, Parasites or No Symbionts") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + scale_color_manual(name="Treatment", values=viridis(4), labels=c("\nMutualists\n", "\nNo Symbionts\n", "\nParasites\n", "\nStructure Present,\nParasites Present\n")) + facet_wrap(~task, scales = "free")+ scale_x_discrete(guide = guide_axis(angle = -40))

###############################################################
###############################################################
#Kruskal Tests
kruskal.test(count ~ treatment, subset(host_data, task=="NOT"))

kruskal.test(count ~ treatment, subset(host_data, task=="NAND"))

kruskal.test(count ~ treatment, subset(host_data, task=="AND"))

kruskal.test(count ~ treatment, subset(host_data, task=="ORN"))

kruskal.test(count ~ treatment, subset(host_data, task=="OR"))

kruskal.test(count ~ treatment, subset(host_data, task=="ANDN"))

kruskal.test(count ~ treatment, subset(host_data, task=="NOR"))

kruskal.test(count ~ treatment, subset(host_data, task=="XOR"))

kruskal.test(count ~ treatment, subset(host_data, task=="EQU"))
###############################################################
###############################################################

#Wilcox Tests For Mutualists versus No Symbionts
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="NOT")$count, subset(host_data, treatment=="No Symbionts" & task=="NOT")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="NAND")$count, subset(host_data, treatment=="No Symbionts" & task=="NAND")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="AND")$count, subset(host_data, treatment=="No Symbionts" & task=="AND")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="ORN")$count, subset(host_data, treatment=="No Symbionts" & task=="ORN")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="OR")$count, subset(host_data, treatment=="No Symbionts" & task=="OR")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="ANDN")$count, subset(host_data, treatment=="No Symbionts" & task=="ANDN")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="NOR")$count, subset(host_data, treatment=="No Symbionts" & task=="NOR")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="XOR")$count, subset(host_data, treatment=="No Symbionts" & task=="XOR")$count)
wilcox.test(subset(host_data, treatment=="Mutualists" & task=="EQU")$count, subset(host_data, treatment=="No Symbionts" & task=="EQU")$count)

###############################################################
###############################################################

#Wilcox Tests for Parasites versus No Symbionts
wilcox.test(subset(host_data, treatment=="Parasites" & task=="NOT")$count, subset(host_data, treatment=="No Symbionts" & task=="NOT")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="NAND")$count, subset(host_data, treatment=="No Symbionts" & task=="NAND")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="AND")$count, subset(host_data, treatment=="No Symbionts" & task=="AND")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="ORN")$count, subset(host_data, treatment=="No Symbionts" & task=="ORN")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="OR")$count, subset(host_data, treatment=="No Symbionts" & task=="OR")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="ANDN")$count, subset(host_data, treatment=="No Symbionts" & task=="ANDN")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="NOR")$count, subset(host_data, treatment=="No Symbionts" & task=="NOR")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="XOR")$count, subset(host_data, treatment=="No Symbionts" & task=="XOR")$count)
wilcox.test(subset(host_data, treatment=="Parasites" & task=="EQU")$count, subset(host_data, treatment=="No Symbionts" & task=="EQU")$count)

###############################################################
###############################################################

#Median values for Experiments with Mutualists
median(subset(host_data, treatment=="Mutualists" & task=="NOT")$count)
median(subset(host_data, treatment=="Mutualists" & task=="NAND")$count)
median(subset(host_data, treatment=="Mutualists" & task=="AND")$count)
median(subset(host_data, treatment=="Mutualists" & task=="ORN")$count)
median(subset(host_data, treatment=="Mutualists" & task=="OR")$count)
median(subset(host_data, treatment=="Mutualists" & task=="ANDN")$count)
median(subset(host_data, treatment=="Mutualists" & task=="NOR")$count)
median(subset(host_data, treatment=="Mutualists" & task=="XOR")$count)
median(subset(host_data, treatment=="Mutualists" & task=="EQU")$count)

#Median values for Experiments with Parasites
median(subset(host_data, treatment=="Parasites" & task=="NOT")$count)
median(subset(host_data, treatment=="Parasites" & task=="NAND")$count)
median(subset(host_data, treatment=="Parasites" & task=="AND")$count)
median(subset(host_data, treatment=="Parasites" & task=="ORN")$count)
median(subset(host_data, treatment=="Parasites" & task=="OR")$count)
median(subset(host_data, treatment=="Parasites" & task=="ANDN")$count)
median(subset(host_data, treatment=="Parasites" & task=="NOR")$count)
median(subset(host_data, treatment=="Parasites" & task=="XOR")$count)
median(subset(host_data, treatment=="Parasites" & task=="EQU")$count)


#Median values for Experiments with No Symbionts
median(subset(host_data, treatment=="No Symbionts" & task=="NOT")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="NAND")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="AND")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="ORN")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="OR")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="ANDN")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="NOR")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="XOR")$count)
median(subset(host_data, treatment=="No Symbionts" & task=="EQU")$count)
