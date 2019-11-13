######## jiebaR ########
#' user_dict.txt 在同個資料夾裡
library(jiebaR)
txt <- "失業的熊讚陪柯文哲看銀翼殺手"



######## 建立 document data frame ########
docs <- c(
  "蝴蝶和蜜蜂們帶著花朵的蜜糖回來了，羊隊和牛群告別了田野回家了，火紅的太陽也滾著火輪子回家了，當街燈亮起來向村莊道過晚安，夏天的夜就輕輕地來了。",
  "朋友買了一件衣料，綠色的底子帶白色方格，當她拿給我們看時，一位對圍棋十分感與趣的同學說：「啊，好像棋盤似的。」「我看倒有點像稿紙。」我說。「真像一塊塊綠豆糕。」一位外號叫「大食客」的同學緊接著說。",
  "每天，天剛亮時，我母親便把我喊醒，叫我披衣坐起。我從不知道她醒來坐了多久了。她看我清醒了，便對我說昨天我做錯了什麼事，說錯了什麼話，要我認錯，要我用功讀書。"
  )



######## 載入範例資料 ########
docs_df <- readRDS("samesex_marriage.rds")



######## Tidytext framework ########
library(tidytext)
library(dplyr)
library(stringr)
library(ggplot2)

# 轉換成 tidytext 格式
tidy_text_format <- docs_df %>%
  unnest_tokens(output = "word", input = "content", 
                token = "regex", pattern = " ")

# 詞頻表 (按 topic 分類)
word_freq <- tidy_text_format %>% 
  group_by(topic, word) %>%
  summarise(n = n()) %>%
  arrange(desc(word), topic)

# 查找特定詞彙
word_freq %>% filter(word == "同志")
word_freq %>% filter(word == "同性戀")
word_freq %>% filter(word %in% c("同志", "同性戀"))
word_freq %>% filter(str_detect(word, pattern = "同志"))

# 視覺化
word_freq %>%
  filter(word %in% c("同志", "同性戀")) %>%
  ggplot() +
  geom_bar(aes(topic, n, fill = word),
           stat = "identity", position = "dodge")



######## quanteda framework ########
library(quanteda)

# 轉換成 quanteda corpus 格式
qcorp <- corpus(docs_df, docid_field = "id", text_field = "content")

# Key word in context
tokens_obj <- tokens(qcorp, "fastestword")
kwic(tokens_obj, pattern = "同(性戀|志)", valuetype = "regex", window = 10)
