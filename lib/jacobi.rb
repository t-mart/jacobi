$: << File.dirname(__FILE__)

require 'gsl'

require "jacobi/version"
require "jacobi/jacobi"

module Jacobi

end

sort = Jacobi::Iterator.random5x5symm
sweep = sort.clone

puts sort.a
puts ""

puts "Sort Algorithm"
n = 0
while sort.sum_off_diag > Jacobi::Iterator::CONVERGENCE_THRESHOLD
  n += 1
  sort.next_sort
end
puts "Took #{n} Jacobi iterations"
puts "Eigenvalues: #{sort.a.diagonal}"

STDOUT.flush

puts ""
puts "Sweep Algorithm"
n = 0
while sweep.sum_off_diag > Jacobi::Iterator::CONVERGENCE_THRESHOLD
  n += 1
  sweep.next_sweep
end
puts "Took #{n} Jacobi iterations"
puts "Eigenvalues: #{sweep.a.diagonal}"
