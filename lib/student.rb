class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    #binding.pry
    student = self.new()
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]

    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
      SELECT * FROM students
    SQL

    rows = DB[:conn].execute(sql)

    students = []
    rows.each {|row| students << self.new_from_db(row)}
    students
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = ?
      LIMIT 1;
    SQL

    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
    
  end

  def self.all_students_in_grade_9
    students_in_grade_9 = []
    self.all.each do |student|
      students_in_grade_9 << student if student.grade == "9"
    end
    students_in_grade_9
  end

  def self.students_below_12th_grade
    below_12th = []
    self.all.each do |student|
      below_12th << student if student.grade.to_i < 12
    end
    below_12th
  end

  def self.first_X_students_in_grade_10(number_of_students_wanted)
    students_in_grade_10 = []
    self.all.each do |student|
      students_in_grade_10 << student if student.grade == "10"
      break if students_in_grade_10.size == number_of_students_wanted
    end
    students_in_grade_10
  end

  def self.first_student_in_grade_10
    students_in_grade_10 = self.all_students_in_grade_X(10)
    first_student = students_in_grade_10[0]
    
    students_in_grade_10.each do |student|
      first_student = student if student.id < first_student.id
    end

    first_student
  end

  def self.all_students_in_grade_X(grade_number)
    students_in_grade = []
    self.all.each do |student|
      students_in_grade << student if student.grade.to_i == grade_number
    end
    students_in_grade
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
