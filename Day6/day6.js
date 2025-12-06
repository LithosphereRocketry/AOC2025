const fs = require('node:fs')

function transpose(arr) {
    return arr[0].map((_, i) => arr.map(row => row[i]))
}

function doRow(row) {
    numstrs = row.slice(0, -1)
    oper = row.at(-1)
    nums = numstrs.map(x => BigInt(x))
    if(oper === "*") {
        return nums.reduce((a, b) => a*b)
    } else {
        return nums.reduce((a, b) => a+b)
    }
}

const data = fs.readFileSync("input.txt", "ascii")
const lines = data.split("\n")
const cells = lines.map((x) => x.split(/\s+/).filter(i => i))
const eqnstrs = transpose(cells)
console.log(eqnstrs.map(doRow).reduce((a, b) => a+b))