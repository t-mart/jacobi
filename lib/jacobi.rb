$: << File.dirname(__FILE__)

require 'gsl'
require 'gruff'

require "jacobi/version"
require "jacobi/jacobi"

module Jacobi

end

sort = Jacobi::Iterator.random5x5symm
sweep = sort.clone

puts sort.a
puts ""
puts "Actual Eigenvalues: #{Jacobi::Iterator.sort_row(sort.actual_eigenvalues)}"
puts ""

puts "Sort Algorithm"
n = 0
sort_points = []
while (off = sort.sum_off_diag) > Jacobi::Iterator::CONVERGENCE_THRESHOLD
  sort_points << Math.log(off)
  n += 1
  sort.next_sort
end
sort_points << off
puts "Took #{n} Jacobi iterations"
puts "Eigenvalues: #{Jacobi::Iterator.sort_row(sort.a.diagonal)}"

sort_points_theoretical = []
sort_points.length.times do |i|
  point = ((i + 1) * Math.log(9/10.0) + Math.log(sort.orig_sum_off_diag))
  sort_points_theoretical << point
end

sort_labels = {0 => '0'}
label_div = sort_points.length / 4
4.times do |i|
  sort_labels[label_div * (i+1)] = (label_div * (i+1)).to_s
end

sort_graph = Gruff::Line.new 800
sort_graph.title = "Jacobi Method Convergence on Random 5x5 Matrix with Sorting"
sort_graph.title_font_size = 24
sort_graph.data("Actual", sort_points)
sort_graph.data("Theoretical", sort_points_theoretical)
sort_graph.labels = sort_labels
sort_graph.write('sorted.png')

STDOUT.flush




#puts ""
#n = 0
#while sweep.sum_off_diag > Jacobi::Iterator::CONVERGENCE_THRESHOLD
  #n += 1
  #sweep.next_sweep
#end
#puts "Took #{n} Jacobi iterations"
#puts "Eigenvalues: #{Jacobi::Iterator.sort_row(sweep.a.diagonal)}"

puts "Sweep Algorithm"
n = 0
sweep_points = []
while (off = sweep.sum_off_diag) > Jacobi::Iterator::CONVERGENCE_THRESHOLD
  sweep_points << Math.log(off)
  n += 1
  sweep.next_sweep
end
sweep_points << off
puts "Took #{n} Jacobi iterations"
puts "Eigenvalues: #{Jacobi::Iterator.sort_row(sweep.a.diagonal)}"

sweep_points_theoretical = []
sweep_points.length.times do |i|
  point = ((i + 1) * Math.log(9/10.0) + Math.log(sweep_sum_off_diag))
  sweep_points_theoretical << point
end

sweep_labels = {0 => '0'}
label_div = sweep_points.length / 4
4.times do |i|
  sweep_labels[label_div * (i+1)] = (label_div * (i+1)).to_s
end

sweep_graph = Gruff::Line.new 800
sweep_graph.title = "Jacobi Method Convergence on Random 5x5 Matrix without Sorting"
sweep_graph.title_font_size = 24
sweep_graph.data("Actual", sweep_points)
sweep_graph.data("Theoretical", sweep_points_theoretical)
sweep_graph.labels = sweep_labels
sweep_graph.write('notsorted.png')
