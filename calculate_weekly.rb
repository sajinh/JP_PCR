require 'pp'
require 'fileutils'

def sum_of(v)
  v.sum
end
def sum_weekly(str_arr)
  yr,mo,dy=[],[],[]
  p,t,di,de=[],[],[],[]
  
  str_arr.each do |str|
    arr = str.chomp.split(",")
    y,m,d=arr[0..2]
    yr << y
    mo << m
    dy << d
    a,b,c,d = arr[3..-1].map {|s| Integer(s)}
    p  << a
    t  << b
    di << c
    de << d
  end
  new_arr = []
  p_sum = sum_of(p)
  t_sum = sum_of(t)
  di_sum = sum_of(di)
  de_sum = sum_of(de)
  str_arr.each_index do |i|
    new_arr << [yr[i],mo[i],dy[i],p_sum,t_sum,di_sum,de_sum].join(",")
  end
  return(new_arr)
end

prefs = IO.readlines("prefectures.list")
in_dir = "./Daily"
out_dir = "./Weekly"
FileUtils.mkdir_p(out_dir)
prefs.each do |pref|
  puts pref

  file_path = "#{File.join(in_dir,pref.chomp)}.csv"
  data = IO.readlines(file_path)[1..-1] # start from 1 to ignore the header

  out_path = "#{File.join(out_dir,pref.chomp)}.csv"
  fout = File.open(out_path,"w")
     # write header
  fout.puts "year,month,day,pcr_positive,pcr_tests,discharged,deaths"

  # column headers are listed below
  # year,month,day,pcr_positive,pcr_tests,discharged,deaths
  positiv, tests, disch,death = 0,0,0,0

  # Add npad data at the start of operation so that
  # the length of data is a multiple of 7
  npad = (7-data.length%7)
  npad.times do
    data.unshift(data[0])  # unshift adds to beginning of data array  
  end
  result = sum_weekly(data[0..6])
  
  # Write the first seven-day average in the beginning

  result[npad..-1].each do |str|
    fout.puts str
  end
  data[7..-1].each_slice(7) do |d| 
    
    sum_weekly(d).each do |str|
      fout.puts str
    end
  end  # loop over data of each prefecture
  fout.close
end  # loop over prefectures
