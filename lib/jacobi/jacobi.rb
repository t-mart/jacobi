include GSL

module Jacobi

  class Iterator

    CONVERGENCE_THRESHOLD = 10e-9

    attr_accessor :a, :orig_sum_off_diag

    def initialize a
      @a = a

      @orig_sum_off_diag = sum_off_diag

      @i = 0
      @j = 1
    end
    
    def clone
      c = self.class.send(:new, @a)
      #c.set_i @i
      #c.set_j @j
      c
    end

    def set_j j
      @j = j
    end

    def set_i i
      @i = i
    end

    def self.random5x5symm
      matrix = [ [], [], [], [], [] ]
      for i in 5.times
        for j in 5.times
          if i >= j
            n = rand -99..99
            matrix[i][j] = n
            matrix[j][i] = n
          end
        end
      end
      new(Matrix.alloc(*matrix))
    end

    def matrix_form_string
      @a.to_a.map do |row|
        "[" + row.map { |ele| sprintf("%-3.3f", ele) }.join(" ") + "]\n"
      end
    end

    #returns [row, col] of the largest upper diagonal entry
    def greatest_off_diag
      max = -Float::INFINITY
      for i in 5.times
        for j in 5.times
          if i < j
            v = @a[i,j].abs
            if max < v
              max = v
              max_index = [i, j]
            end
          end
        end
      end
      max_index
    end

    def actual_eigenvalues
      a.eigen_symmv[0]
    end

    def self.sort_row(r)
      Matrix.alloc(r.to_a.sort)
    end

    def givens_matrix(row, col)
      givens = Matrix.eye 5

      block = Matrix.alloc( [ @a[row,row], @a[row,col] ], [@a[col,row], @a[col, col]])

      u = block.eigen_symmv[1]

      theta = Math.acos(u[0,0])

      givens[row,row] = Math.cos(theta)
      givens[row,col] = Math.sin(theta) * (-1)
      givens[col,row] = Math.sin(theta)
      givens[col,col] = Math.cos(theta)

      givens
    end

    def next_sort
      greatest = greatest_off_diag
      g = givens_matrix(greatest[0], greatest[1])
      
      @a = g.transpose * @a * g
    end

    def next_sweep
      g = givens_matrix(@i, @j)

      incr_ij
      while @a[@i,@j].abs < CONVERGENCE_THRESHOLD
        incr_ij
      end
      
      @a = g.transpose * @a * g
    end

    def incr_ij
      if @j == 4
        if @i == 3 #restart
          @i = 0
          @j = 1
        else #new row
          @i += 1 
          @j = @i + 1
        end
      else #new col
        @j += 1
      end
    end

    def sum_off_diag
      sum = 0.0
      for i in 5.times
        for j in 5.times
          if i != j
            sum += a[i,j]
          end
        end
      end
      sum**2
    end
  end
end
