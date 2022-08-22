class Person < ApplicationRecord
  require 'json'
  require 'matrix'

  validates :dna_string, uniqueness: true
  after_create :define_type_of_person

  def define_type_of_person
    self.update(is_mutant: validate_mutant(dna_string))
  end

  private

  def validate_mutant(dna_string)
    dna = JSON.parse(dna_string)
    m = Matrix.build(6) {|row, col| col = dna[row][col] }
    dna_arrays = []
    dna_arrays += get_columns(m)
    dna_arrays += get_rows(m)
    dna_arrays += get_diagonals(m)
    determinate(dna_arrays)
  end

  def get_columns(matrix)
    columns = []
    column_length = matrix.column_size
    count = 0
    while count < column_length
      columns << matrix.column(count).to_a
      count += 1
    end
    columns
  end
      
  def get_rows(matrix)
    rows = []
    row_length = matrix.column_size
    count = 0
    while count < row_length
      rows << matrix.row(count).to_a
      count += 1
    end
    rows
  end
      
  def get_diagonals(matrix)
    diagonals = []
    diagonals << [matrix[0,0], matrix[1,1], matrix[2,2], matrix[3,3], matrix[4,4], matrix[5,5]] #1
    diagonals << [matrix[1,0], matrix[2,1], matrix[3,2], matrix[4,3], matrix[5,4]] #2
    diagonals << [matrix[2,0], matrix[3,1], matrix[4,2], matrix[5,3]] #3
    diagonals << [matrix[0,1], matrix[1,2], matrix[2,3], matrix[3,4], matrix[4,5]] #4
    diagonals << [matrix[0,2], matrix[1,3], matrix[2,4], matrix[3,5]] #5
    diagonals << [matrix[0,3], matrix[1,2], matrix[2,1], matrix[3,0]] #6
    diagonals << [matrix[0,4], matrix[1,3], matrix[2,2], matrix[3,1], matrix[4,0]] #7
    diagonals << [matrix[0,5], matrix[1,4], matrix[2,3], matrix[3,2], matrix[4,1], matrix[5,0]] #8
    diagonals << [matrix[1,5], matrix[2,4], matrix[3,3], matrix[4,2], matrix[5,1]] #9
    diagonals << [matrix[2,5], matrix[3,4], matrix[4,3], matrix[5,2]] #10
    diagonals
  end
      
  def determinate(dna_strings)
    str_mutant = ["A", "A", "A", "A"], ["T", "T", "T", "T"], ["C", "C", "C", "C"], ["G", "G", "G", "G"]
    determinate = []
    dna_strings.each do |dna_str|
      str_mutant.each do |str|
        determinate << dna_str if dna_str.join.include?(str.join)
      end
    end
    !determinate.empty?
  end
end