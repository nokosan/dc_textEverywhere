const jsonToObj = (filepath) => {
  const data = fs.readFileSync(filepath, { encoding: "utf8", flag: "r" });
  return JSON.parse(data);
};
