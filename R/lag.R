x <- stocks  %>% 
  arrange(symbol, v.date)  %>%  
  group_by(symbol)  %>% 
  mutate(lag_price = lag(price), pret = (price - lag_price)/lag_price)  
  