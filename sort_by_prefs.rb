
def parse_string(str,pref)
  arr = str.split(",").map {|e| e.delete('"')}
  pnm= arr[4].chomp 
  return([arr[0..2],(arr[5..8].map! {|e| e.empty? ? e=0.0 : Float(e)})].join(",")) if pnm==pref
  abort "Missing or unknown prefecture"
end

prefs = IO.readlines("prefectures.list")
fnm = "covid19/data/prefectures.csv"
fin = File.open(fnm,"r")

# open files to write out data per prefecture
outfil_handles=[]
  prefs.each do |pref|
    outfil_handles << File.open("#{pref.chomp}.csv","w")
  end
#read the header
fin.gets

outfil_handles.each do |of|
  of.puts "year,month,day,pcr_positive,pcr_tests,discharged,deaths"
end


#begin
while !fin.eof?
  prefs.each_with_index do |pref,i|
    outfil_handles[i].puts parse_string(fin.gets.chomp,pref.chomp)
  end
end

p "Exiting loop"
outfil_handles.each {|of| of.close}


