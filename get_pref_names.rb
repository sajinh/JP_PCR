
fnm = "covid19/data/prefectures.csv"
fin = File.open(fnm,"r")
p fin.gets
prefs =[]
47.times do
  pnm= fin.gets.split(",")[4]
  prefs<< pnm.delete('"')
end
fin.close
File.open("prefectures.list","w") {|f| f.puts prefs}
