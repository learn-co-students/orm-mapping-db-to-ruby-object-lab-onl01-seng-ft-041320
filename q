
[1mFrom:[0m /mnt/c/Users/enyia.DESKTOP-TUU2H13/OneDrive/Documents/Learning_Programing/flatIron/labs/ORM/orm-mapping-db-to-ruby-object-lab-onl01-seng-ft-041320/lib/student.rb @ line 46 Student.all_students_in_grade_9:

    [1;34m41[0m: [32mdef[0m [1;36mself[0m.[1;34mall_students_in_grade_9[0m
    [1;34m42[0m: 
    [1;34m43[0m:   [1;36mself[0m.all.collect [32mdo[0m |student| 
    [1;34m44[0m:     [32mif[0m student.grade == [31m[1;31m'[0m[31m9[1;31m'[0m[31m[0m
    [1;34m45[0m:       [1;34;4mStudent[0m.find_by_name(student.name) 
 => [1;34m46[0m:       binding.pry
    [1;34m47[0m:       [32mend[0m
    [1;34m48[0m:     [32mend[0m
    [1;34m49[0m: 
    [1;34m50[0m: [32mend[0m

