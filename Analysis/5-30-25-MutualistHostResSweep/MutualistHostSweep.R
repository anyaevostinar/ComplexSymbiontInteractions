require(ggplot2)
#install.packages("viridis")
library(viridis)
library(scales)

#Set your working directory to the Analysis folder for your project

#Read in the data
initial_data <- read.table("munged_basic1-15.dat", h=T)
secondary_data <- read.table("munged_basic15-30.dat", h=T)
initial_data <- rbind(initial_data, secondary_data)
initial_data$task <- factor(initial_data$task, levels=c("NOT", "NAND", "AND", "ORN", "OR", "ANDN", "NOR", "XOR", "EQU"))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("MOI0.0_REPRO10", "MA R10", x)}))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("MOI0.0_REPRO50", "MA R50", x)}))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("MOI0.0_REPRO75", "MA R75", x)}))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("MOI1.0_REPRO10", "MP R10", x)}))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("MOI1.0_REPRO50", "MP R50", x)}))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("MOI1.0_REPRO75", "MP R75", x)}))
initial_data[2] <- data.frame(lapply(initial_data[2], function(x) {gsub("_", " ", x)}))
final_update <- subset(initial_data, update == "100000")

host_data <- subset(final_update, partner == "Mutualist")

#Plot the host task counts at final update

#violin plot?
#ggplot(data=host_data, aes(x=treatment, y=count, color=treatment)) + geom_violin() + ylab("Task Count Final Update") + xlab("Parasites Present or Absent") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + scale_color_manual(name="Parasites", values=viridis(3)) + facet_wrap(~task, scales = "free") + geom_boxplot(alpha=0.5, outlier.size=0, width=0.1) 

#regular box plot
#ggplot(data=host_data, aes(x=treatment, y=count, color=treatment)) + geom_boxplot(alpha=0.5, outlier.size=1) + ylab("Boolean Logic Operation Count Final Update") + xlab("Structure and Parasites Absent or Present") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + scale_color_manual(name="Treatment", values=viridis(4), labels=c("\nStructure Absent,\nParasites Absent\n", "\nStructure Absent,\nParasites Present\n", "\nStructure Present,\nParasites Absent\n", "\nStructure Present,\nParasites Present\n")) + facet_wrap(~task, scales = "free")+ scale_x_discrete(guide = guide_axis(angle = -40))



#wilcox.test(subset(host_data, treatment=="Absent" & task=="NOT")$count, subset(host_data, treatment=="Present" & task=="NOT")$count)
#median(subset(host_data, treatment=="Absent" & task=="NOT")$count)
#median(subset(host_data, treatment=="Present" & task=="NOT")$count)
#wilcox.test(subset(host_data, treatment=="Absent" & task=="NAND")$count, subset(host_data, treatment=="Present" & task=="NAND")$count)
#median(subset(host_data, treatment=="Absent" & task=="NAND")$count)
#median(subset(host_data, treatment=="Present" & task=="NAND")$count)
#wilcox.test(subset(host_data, treatment=="Absent" & task=="AND")$count, subset(host_data, treatment=="Present" & task=="AND")$count)
#wilcox.test(subset(host_data, treatment=="Absent" & task=="ANDN")$count, subset(host_data, treatment=="Present" & task=="ANDN")$count)
#wilcox.test(subset(host_data, treatment=="Absent" & task=="OR")$count, subset(host_data, treatment=="Present" & task=="OR")$count)
#median(subset(host_data, treatment=="Absent" & task=="OR")$count)
#median(subset(host_data, treatment=="Present" & task=="OR")$count)
#wilcox.test(subset(host_data, treatment=="Absent" & task=="ORN")$count, subset(host_data, treatment=="Present" & task=="ORN")$count)

#All tasks over time
ggplot(data=initial_data, aes(x=update, y=count, group=treatment, colour=treatment)) + ylab("Task count") + xlab("Updates") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) +scale_colour_manual(values=viridis(6)) + scale_fill_manual(values=viridis(6)) + facet_grid(task ~ partner, scales='free')

# Specific host tasks over time
host_over_time <- subset(initial_data, partner=="Host")
limited_tasks <- subset(host_over_time, task=="NOT" | task=="NAND" | task=="AND" | task=="ORN" | task=="OR" | task=="ANDN" | task=="NOR"| task=="XOR" | task=="EQU")

ggplot(data=limited_tasks, aes(x=update, y=count, group=treatment, colour=treatment)) + ylab("Task count") + xlab("Updates") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) +scale_colour_manual(name = "Hosts", values=viridis(6)) + scale_fill_manual(values=viridis(6)) + facet_grid(task ~ treatment, scales='free')

# Specific parasite tasks over time
parasite_over_time <- subset(initial_data, partner=="Mutualist")
para_limited_tasks <- subset(parasite_over_time, task=="NOT" | task=="NAND" | task=="AND" | task=="ORN" | task=="OR" | task=="ANDN" | task=="NOR"| task=="XOR" | task=="EQU")

ggplot(data=para_limited_tasks, aes(x=update, y=count, group=treatment, colour=treatment)) + ylab("Task count") + xlab("Updates") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) +scale_colour_manual(name = "Mutualists", values=viridis(6)) + scale_fill_manual(values=viridis(6)) + facet_grid(task ~ treatment, scales='free')
#Tasks over time by replicate
NAND <- subset(initial_data, task=="NAND")
NOT <- subset(initial_data, task=="NOT")
AND <- subset(initial_data, task=="AND")

ggplot(data=NOT, aes(x=update, y=count, group=treatment, colour=treatment)) + ylab("Task count") + xlab("Updates") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) +scale_colour_manual(values=viridis(3)) + scale_fill_manual(values=viridis(3)) + facet_grid(partner~rep, scales='free')