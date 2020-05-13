class Student
  attr_accessor :id, :name, :grade

  def self.all_students_in_grade_9
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
      SQL
    DB[:conn].execute(sql, '9')
  end

  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade < ?
      SQL
      rows = DB[:conn].execute(sql, '12')
      rows.map {|row| self.new_from_db(row)}
  end

  def self.new_from_db(row)
    student = self.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    sql = <<-SQL
      SELECT *
      FROM students
      SQL
    rows_array = DB[:conn].execute(sql)
    # remember each row should be a new instance of the Student class
    rows_array.map {|row| Student.new_from_db(row)}
  end

  def self.first_X_students_in_grade_10(x)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = 10
      LIMIT ?
      SQL
    rows = DB[:conn].execute(sql, x)
    rows.map{|row| self.new_from_db(row)}
  end

  def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = 10
      LIMIT 1
      SQL
      row = DB[:conn].execute(sql)
      self.new_from_db(row[0])
  end

  def self.all_students_in_grade_X(x)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
      SQL
      rows = DB[:conn].execute(sql, x)
      rows.map{|row| self.new_from_db(row)}
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = ?
      SQL
    row = DB[:conn].execute(sql, name)[0]
    # return a new instance of the Student class
    self.new_from_db(row)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
