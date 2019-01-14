require 'rubygems'
require 'rest-client'
require 'json'
require 'minitest/autorun'
require 'pry'

# #### Commands
# Add: The row begins with capital letter `A` followed by a number of digits, ex: `A18237283`
# Clear: The row begins with capital letter `C`
# Checksum: The row begings with letters `CS`

class TestReportSystem < MiniTest::Test
	def setup
	  #@browser = Object.new
	end

	def teardown
	  #@browser.close
	end

	def test_scenario
		scenario = <<-eos
			C
			A24
			CS
			A47
			CS
			A1112
			CS
			C
			A90
			CS
			C
			A5218900797
			8442
			CS
			C
			A8215529768332323333588123515888912412
			CS
			C
			A11
			CS
			A11
			A11
			A11
			A11
			A11
			A11
			11
			A12
			CS
			A22222
			A33333
			CS
			A3
			CS
		eos

		run_scenario(scenario)
	end


	def run_scenario(commands)
		commands.each_line do |row|
			numbers = cleanup_string(row.gsub(/[^\d]/, ''))

			case extract_command(row)
				when 'CS'
					puts "Checksum: #{numbers}"
				when 'C'
					puts "Clear: #{numbers}"
				when 'A'
					puts "Append: #{numbers}"
			end
		end
	end

	def extract_command(row)
		cleanup_string(row.gsub(/[\d]/, ''))
	end

	def extract_numbers(row)
		cleanup_string(row.gsub(/[^\d]/, ''))
	end

	def cleanup_string(string)
		string.gsub(/\t/,'').gsub(/\n/, '')
	end
end