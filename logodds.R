# Probability, odds, and logodds

# See http://www.ats.ucla.edu/stat/mult_pkg/faq/general/odds_ratio.htm

source('multiplot.R')

probs = seq(from=0, to=1, length.out=1000)
odds  = probs/(1-probs)
logodds = log(odds)

o1 <- qplot(probs, odds, ylim=c(0,10)) + geom_hline(aes(yintercept=1)) +  annotate("text", x = 0.9, y = 1.4, label = "odds = 1")
o2 <- qplot(odds,logodds, xlim=c(0,10)) + geom_vline(aes(xintercept=1)) + annotate("text", x = 1.7, y = 6,   label = "odds = 1")
multiplot(o1, o2)
