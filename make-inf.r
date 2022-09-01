n.pop = c(57206,17699,13880,31498,4480)
n.pop.all = sum(n.pop)
p.pop = n.pop/n.pop.all
n.inf = 200
t = 1439

file=sprintf("inf%d.csv",n.inf)

cat(file=file, n.inf,"\n",append=F)
for (town in 0:4) {
  for (i in 0:round(p.pop[town+1]*n.inf)) {
    line = sprintf("INF,%d,%d,%d\n",t, town,1000+i)
    cat(file=file, line,append=T)
  }
}
