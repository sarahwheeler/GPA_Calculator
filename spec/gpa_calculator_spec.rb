require 'spec_helper'
require 'gpa_calculator'

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

describe "GpaCalculator" do
	before do
		@calculator = GpaCalculator::Calculator.new
		@courses = {"English" => 72, "Math" => 99, "Science" => 100 }
	end
	describe "#start_program" do
		it "should start by requesting a course name" do
			@calculator.stub(:start_program) {"English"}.and_return("English")
		end
	end
	describe "#more_courses?" do
		it "should return the course name prompt for y/yes answers" do
			@calculator.stub(:more_courses?) {"y"}.and_return("Enter course name: ")
			@calculator.stub(:more_courses?) {"Yes"}.and_return("Enter course name: ")
		end
		it "should print the course report table for n/no answers" do
			@calculator.stub(:more_courses?) {"n"}.and_return("\nCOURSE   \t| GRADE   \t| POINTS")
			@calculator.stub(:more_courses?) {"No"}.and_return("\nCOURSE   \t| GRADE   \t| POINTS")
		end
		it "should" do
			@calculator.stub(:more_courses?) {"whatever"}.and_return("Sorry, I didn't understand that. Please select y/n or yes/no.")
		end
	end
	describe "course name validations" do
		it "should not allow blank or empty course names" do
			@calculator.stub(:course_name_validation) {" "}.and_return("Enter course name (required): ")
			@calculator.stub(:course_name_validation) {""}.and_return("Enter course name (required): ")
		end
		it "should allow course names with numbers and dashes" do
			@calculator.stub(:course_name_validation) {"CS-101"}.and_return("Enter course grade: ")
		end
	end
	describe "course grade validations" do
		it "should not allow blank or empty course grades" do
			@calculator.stub(:course_grade_validation) {""}.and_return("Enter course grade (required): ")
			@calculator.stub(:course_grade_validation) {" "}.and_return("Enter course grade (required): ")
		end
		it "should not allow course letter grades that aren't A-F" do
			@calculator.stub(:course_grade_validation) {"pass"}.and_return("Enter course grade (required): ")
		end
		it "should accept floats and integers" do
			@calculator.stub(:course_grade_validation) {88.0}.and_return(88.0)
			@calculator.stub(:course_grade_validation) {88}.and_return(88)
		end
		it "should accept letter grades and pluses/minuses" do
			@calculator.stub(:course_grade_validation) {"A+"}.and_return("A+")
			@calculator.stub(:course_grade_validation) {"C"}.and_return("C")
		end
	end
	describe "#calculate_avg" do
		it "should find the correct average for the course scores" do
			@calculator.stub(:calculate_avg).and_return("\nCumulative Average:\t 90.334")
		end
	end
	describe "#calculate_gpa" do
		it "should find the correct GPA for the course scores" do
			@calculator.stub(:calculate_gpa).and_return("Cumulative GPA:\t\t 3.234")
		end
	end
end