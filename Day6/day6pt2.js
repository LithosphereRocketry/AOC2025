const fs = require('node:fs')

function transpose(arr) {
    return arr[0].map((_, i) => arr.map(row => row[i]))
}

function doRow(row) {
    oper = row[0].split("").at(-1)
    nums = row.map(x => BigInt(x.slice(0, -1)))
    if(oper === "*") {
        return nums.reduce((a, b) => a*b)
    } else {
        return nums.reduce((a, b) => a+b)
    }
}

const data = fs.readFileSync("input.txt", "ascii")
const lines = data.split("\n")
const rows = lines.length

const rowarrs = transpose(lines.map(x => x.split("")))
const groupblob = rowarrs.map(x => x.join("")).join("|")
const groups = groupblob.split("|" + " ".repeat(rows) + "|").map(x => x.split("|"))

console.log(groups.map(doRow).reduce((a, b) => a+b))