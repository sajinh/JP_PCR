require 'gruff'
require 'pp'

file_path = "Weekly/Osaka.csv"
data = IO.readlines(file_path)[1..-1]
dates, tests = [],[]
data.each do |d| 
  y,m,d,p,t,di,de=d.chomp.split(",")
  dates<< [m,d].join("/") 
  #metric = (Integer(t)<=Integer(p) ? 0.0: 100.0*Float(p)/Float(t))
  metric = (Integer(t)<=Integer(p) ? 0.0: Float(t))
  tests<<metric
  #tests<<(t.to_f)
end
dsize = dates.size
keys = (0..dsize-1).to_a
sel_dates = dates.select.with_index { |_,i| i%20==0}
sel_keys  = keys.select.with_index { |_,i| i%20==0}
labels = Hash[sel_keys.zip(sel_dates)]
g = Gruff::Bar.new
g.title = 'Wow!  Look at this!'
g.labels = labels
#g.theme = Gruff::Themes::ODEO
g.theme = {
         colors: %w(blue purple green white red),
         marker_color: 'blue',
         background_colors: ['white', 'white'],
         background_direction: :top_bottom
       }
              
g.data :tests, tests
g.write('exciting.png')
