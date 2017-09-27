pkg name
===============

## install

```
devtools::install_github("6Youcai/Xtable")
```

## Tables

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

## rowspan

`$v2;`

```{r, echo=FALSE, results='asis'}
library(Xtable)
text <- "First Header  | Second Header | Third Header
------------- | ------------- | ------------
$v2;Content Cell  | Content Cell  | Content Cell
Content Cell  | Content Cell  
"
Xtable::Mtable(text)
```

## colspan

`$>3;`

```{r, echo=FALSE, results='asis'}
text <- "
First Header  | Second Header | Third Header | Fourth Header
------------- | ------------- | ------------ | -------------  
Content Cell  | Content Cell  | Content Cell | Content Cell
Content Cell  |$>3;Content Cell
$>2;Content Cell | Content Cell  | Content Cell
"
Mtable(text)
```

## mixed

```{r, echo=FALSE, results='asis'}
text <- "
Content Cell  | Content Cell  | Content Cell | Content Cell | Content Cell
Content Cell  | $v2;$>2;Content Cell  | Content Cell 
Content Cell  | Content Cell  | Content Cell
Content Cell  | Content Cell  | Content Cell | Content Cell 
Content Cell  | Content Cell  | $>3;Content Cell 
"
Mtable(text)
```

