library(tidyverse)
library(fpp2)
library(readxl)

ATM624Data = read_excel("ATM624Data.xlsx", col_types = c("date", "text", "numeric"))
ATM.new = ATM624Data %>% drop_na() %>% spread(ATM, Cash) 

temp = ts(ATM.new %>% select(-DATE))
ATM.ts = temp
for (i in 1:4){
  ATM.ts[,i] = tsclean(ATM.ts[,i])
}

ATM.df = reshape2::melt(ATM.ts)
ATM.df = cbind(DATE = seq(as.Date("2009-05-1"), as.Date("2010-04-30"), length.out = 365), ATM.df[,-1])
names(ATM.df) = c("DATE", "ATM", "Cash")

library(gganimate)

# ts = ggplot(ATM.df, aes(x = DATE, y = Cash, group = ATM, color = ATM)) +
#   geom_line() + geom_point() +
#   labs(title = "ATM Cash Withdrawal", subtitle ="1 May, 2009 to 30 April, 2010", 
#        x = "Date") +
#   scale_y_continuous("Amount of Cash Withdrawal", 
#                      labels = scales::dollar_format(scale = 0.1, suffix = "K")) +
#   theme_minimal() + transition_reveal(DATE)
# 
# animate(ts, height = 6, width = 9, units = "in", res = 150)
# anim_save("atm.gif")

# df = with(ATM.df, ATM.df[(DATE >= "2009-07-01" & DATE <= "2009-08-31"), ])
# ts = ggplot(df, aes(x = DATE, y = Cash, group = ATM, color = ATM)) +
#   geom_line() + geom_point() +
#   labs(title = "ATM Cash Withdrawal", subtitle ="1 July, 2009 to 31 August, 2009", 
#        x = "Date") +
#   scale_y_continuous("Amount of Cash Withdrawal", 
#                      labels = scales::dollar_format(scale = 0.1, suffix = "K")) +
#   theme_minimal() + transition_reveal(DATE)
# 
# animate(ts, height = 6, width = 9, units = "in", res = 150)
# anim_save("atm_zoom.gif")
