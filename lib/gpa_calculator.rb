require "gpa_calculator/version"

module GpaCalculator
  class Calculator

		def start_program
			@courses = {}
			add_course
			more_courses?
		end

		def add_course
			name = add_course_name
			score = add_course_score
			save_course(name, score)
		end

		def add_course_name
			print "Enter course name: "
			name = gets.chomp
			course_name_validation(name)
		end

		def add_course_score
			print "Enter course grade: "
			score = gets.chomp
			course_grade_validation(score)
		end

		def more_courses?
			print "Do you want to add another course? (y/N) "
			add_more = gets.chomp.downcase
			if add_more == "y" || add_more == "yes"
				add_course
				more_courses?
			elsif add_more == "n" || add_more == "no"
				print_table
				calculate_avg
				calculate_gpa
			else
				puts "Sorry, I didn't understand that. Please select y/n or yes/no."
				more_courses?
			end
		end

		def course_name_validation(name)
			if name == "" || name == " " || name.match(/[a-zA-Z0-9\-]+/) == nil
				print "Enter course name (required): "
				name = gets.chomp
				course_name_validation(name)
			else
				name
			end
		end

		def course_grade_validation(grade)
			grade.tr!('%', '')
			if grade == "" || grade == " " || grade.match(/[e-zE-Z]+/)
				print "Enter course grade (required): "
				grade = gets.chomp
				course_grade_validation(grade)
			elsif grade.match(/[a-fA-F]\-?\+?/)
				grade_to_percent(grade)
			else
				grade
			end
		end

		def save_course(name, score)
			@courses.store(name, score.to_f)
		end

		def print_table
			puts "\nCOURSE   \t| GRADE   \t| POINTS"
			puts "-----------  \t|----------- \t|-----------"
			@courses.each do |name, score|
				puts "#{fit_course_name(name)} \t| #{score.to_f}\t\t| #{percent_to_points(score)}" 
			end
		end

		def calculate_avg
			total = @courses.values.inject { |sum, x| sum + x }
			average = total/@courses.length
			puts "\nCumulative Average:\t #{average.round(3)}"
		end

		def calculate_gpa
			total = @courses.values.inject(percent_to_points(0)) { |sum, x| sum + percent_to_points(x) }
			average = total/@courses.length
			puts "Cumulative GPA:\t\t #{average.round(3)}"
		end

		def fit_course_name(name)
			if name.length >= 14
				name.capitalize.slice(0,10) + ("...")
			elsif name.length <= 6
				name.capitalize + ("\t")
			else
				name.capitalize
			end
		end

		def percent_to_points(grade)
			case grade.to_f
			when 97.0..1000.0
				points = 4.0
			when 93.0..96.99
				points = 4.0
			when 90.0..92.99
				points = 3.7
			when 87.0..89.99
				points = 3.3
			when 83.0..86.99
				points = 3.0
			when 80.0..82.99
				points = 2.7
			when 77.0..79.99
				points = 2.3
			when 73.0..76.99
				points = 2.0
			when 70.0..72.99
				points = 1.7
			when 67.0..69.99
				points = 1.3
			when 65.0..66.99
				points = 1.0
			when -1000.0..64.99
				points = 0
			else
				puts "An error has occurred"
			end
			points
		end

		def grade_to_percent(grade)
			case grade.capitalize
			when "A+"
				percent = 97
			when "A"
				percent = 93
			when "A-"
				percent = 90
			when "B+"
				percent = 87
			when "B"
				percent = 83
			when "B-"
				percent = 80
			when "C+"
				percent = 77
			when "C"
				percent = 73
			when "C-"
				percent = 70
			when "D+"
				percent = 67
			when "D"
				percent = 65
			when "F"
				percent = 64
			else
				print "Enter course grade (required): "
				grade = gets.chomp
				course_grade_validation(grade)
			end
			percent
		end
	end
end
