library(ggplot2)
library(ggpattern)
boxp <- read.csv("~/Documents/Katzner/boxplot.csv")
long <- reshape(boxp, varying = c("CORA", "FEHA", "GOEA", "RLHA", "RTHA"), v.names = "val", timevar = "spp", times = c("CORA", "FEHA", "GOEA", "RLHA", "RTHA"), direction="long")
long$id <- NULL
wide <- reshape(long, v.names = "val", timevar = "iqr", idvar = c("season", "spp"))
wide$spp_season <- paste(wide$season, wide$spp)
names(wide)[3] <- "low"
names(wide)[7] <- "high"
theme_set(theme_bw())
ggplot(wide,aes(x=factor(season, levels=c("Winter", "Spring", "Summer")), #
              ymin=low,lower=val.Q1,middle=val.Med,upper=val.Q3,ymax=high, fill=as.factor(spp))) +
  geom_boxplot_pattern(stat="identity", aes(pattern = spp)) + facet_grid(cols = vars(spp)) +
  scale_fill_manual(values=c("FEHA" = "white", "GOEA" = "grey", "CORA" = "white", "RLHA" = "grey")) + # manually assign colors
  scale_pattern_manual(values= c("FEHA" = "none", "GOEA" = "none", "CORA" = "stripe", "RLHA" = "stripe", "RTHA" = "none")) + #xlab("Season") +
  ylab("Est. number shot birds") + scale_y_continuous(limits = c(-0.5, NA)) + 
  #geom_hline(yintercept = -0.5, color = "black") + #scale_x_continuous(limits = c(-0.5, NA)) +
  #geom_vline(xintercept = 0, color = "black") +
  theme(axis.text = element_text(size = 12, color="black"), strip.text = element_text(size = 12), axis.title = element_text(size = 12), legend.position = 'none', axis.line=element_line(colour="black"), axis.title.x=element_blank())
#ggsave("my_file.wmf", device="wmf")

