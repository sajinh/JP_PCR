require 'pp'
require 'fileutils'


prefs = IO.readlines("prefectures.list")
in_dir = "./Total"
out_dir = "./Daily"
FileUtils.mkdir_p(out_dir)
prefs.each do |pref|
  puts pref
  file_path = "#{File.join(in_dir,pref.chomp)}.csv"
  data = IO.readlines(file_path)[1..-1] # start from 1 to ignore the header
  out_path = "#{File.join(out_dir,pref.chomp)}.csv"
  fout = File.open(out_path,"w")
  # column headers are listed below
  # year,month,day,pcr_positive,pcr_tests,discharged,deaths
  fout.puts "year,month,day,pcr_positive,pcr_tests,discharged,deaths"
  positiv, tests, disch,death = 0,0,0,0
  data.each do |d| 
    
    str_arr=d.chomp.split(",")
    y,m,d=str_arr[0..2]
    p,t,di,de=str_arr[3..-1].map {|s| Integer(s)}
    new_p, new_t, new_di, new_de = p,t,di,de
    p  = p-positiv
    t  = t-tests
    di = di-disch
    de = de-death
    positiv, tests,disch,death = new_p,new_t,new_di,new_de
    fout.puts [y,m,d,p,t,di,de].join(",")
  end
  fout.close
end
