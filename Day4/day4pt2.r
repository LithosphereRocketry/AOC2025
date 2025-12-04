library(gsignal)
library(readr)

lines = read_delim("input.txt", col_names=FALSE, delim="bleh")
listlist = Map(function(x) strsplit(x, ""), lines)
mat = (matrix(unlist(listlist), nrow=dim(lines)) == "@") * 1
kernel = matrix(c(1, 1, 1, 1, 0, 1, 1, 1, 1), nrow=3)

adjs = conv2(mat, kernel, shape="same")
score = 0
while (TRUE) {
    hits = (adjs < 4) * mat
    n_rolls = sum(hits)
    if (n_rolls == 0) {
        break
    }
    score = score + n_rolls
    new_frees = conv2(hits, kernel, shape="same")
    adjs = adjs - new_frees
    mat = mat - hits
}

print(score)