cell <- function(x, header = FALSE) {
  # trim blank
  x <- str_replace(x, "^\\s+", "") %>%
    str_replace(., "\\s+$", "")
  if(x == "") return("")
  # use $>2 for colspan, $v3 for rowspan
  if(str_detect(x, "\\$v\\d+;")) {
    rowspan <- str_match(x, "\\$v(\\d+);")[2] %>%
      paste0(' rowspan="', ., '"')
    x <- str_replace(x, "\\$v\\d+;", "")
  } else
    rowspan <- ""

  if(str_detect(x, "\\$>\\d+;")) {
    colspan <- str_match(x, "\\$>(\\d+);")[2] %>%
      # default is left
      paste0(' align=\"center\" colspan="', ., '"')
    x <- str_replace(x, "\\$>\\d+;", "")
  } else
    colspan <- ""
  # header or not
  tag <- ifelse(header, "th", "td")
  paste0("<", tag, rowspan, colspan, ">") %>%
    paste0(., x, "</", tag, ">")
}

Line <- function(text, isheader = FALSE) {
  h_tag <- ifelse(isheader, " class=\"header\"", "")
  str_split(text, "\\|")[[1]] %>%
    sapply(., cell, header = isheader) %>%
    paste0(., collapse = "\n") %>%
    paste0("<tr", h_tag, ">\n", ., "\n</tr>") %>%
    str_replace_all(., "\n+", "\n")
}

####
####
Mtable <- function(raw_text) {
  # pretreat
  text_arr <- str_replace(raw_text, "^\\n", "") %>%
    str_replace(., "\\n$", "") %>%
    str_split(., "\\n")
  text_arr <- text_arr[[1]]
  have_header <- str_detect(text_arr[2], "\\-+\\s*\\|\\s*\\-+")

  if(have_header) {
    # header detected
    t_header <- Line(text_arr[1], TRUE)
    t_body <- sapply(text_arr[3: length(text_arr)], Line) %>%
      paste0(., collapse = "\n")
    paste0("<table><thead>",
          t_header, "</thead>",
          "<tbody>", t_body,
          "</tbody></table>") %>% cat
  } else {
    # without header
    t_body <- sapply(text_arr, Line) %>%
      paste0(., collapse = "\n")
    paste0("<table><tbody>", t_body, "</tbody></table>") %>% cat
  }
}
