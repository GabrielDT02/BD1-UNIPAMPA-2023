const fs = require("fs");
const readline = require("readline");
const stream = fs.createReadStream("./baseDados.csv", 'utf-8');

const rl = readline.createInterface({ input: stream });
let data = [];

rl.on("line", (row) => {
  data.push(row.split(","));
});

rl.on("close", () => {
  console.log(data);
});