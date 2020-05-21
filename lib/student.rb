class Student
  attr_accessor :id, :name, :grade

  @@all = nil

  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
  end

  def self.all
    @@all = DB[:conn].execute("SELECT * FROM students").map {|row| new_from_db(row)}
  end

  def self.all_students_in_grade_9
    self.all.select do |student|
      student.grade == "9"
    end
  end

  def self.students_below_12th_grade
    self.all.select {|student| student.grade < "12"}
  end

  def self.first_X_students_in_grade_10(limit)
    students = self.all.select {|student| student.grade == "10"}
    students[0..limit - 1]
  end

  def self.first_student_in_grade_10
    self.all.find {|student| student.grade == "10"}
  end

  def self.all_students_in_grade_X(grade)
    self.all.select {|student| student.grade == grade.to_s}
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM students
          WHERE name == ?"
    new_from_db(DB[:conn].execute(sql, name)[0])
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
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  


  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end