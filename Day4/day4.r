library(gsignal)
library(readr)

lines = read_delim("input.txt", col_names=FALSE, delim="bleh")
listlist = Map(function(x) strsplit(x, ""), lines)
mat = (matrix(unlist(listlist), nrow=dim(lines)) == "@") * 1
kernel = matrix(c(1, 1, 1, 1, 0, 1, 1, 1, 1), nrow=3)

adjs = conv2(mat, kernel, shape="same")
hits = (adjs < 4) * mat

print(sum(hits))