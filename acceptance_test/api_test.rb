# frozen_string_literal: true

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
		#@pid = fork do
		#  exec "mix run --no-halt"
		#end
	end

	def teardown
		#Process.kill "TERM", @pid
		#Process.wait @pid
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

	BASE_URL = 'http://localhost:4000/api'


	def run_scenario(commands)
		checksum = ""
		commands.each_line do |row|
			numbers = cleanup_string(row.gsub(/[^\d]/, ''))
			command = extract_command(row)

			case command
				when 'CS'
					puts "Checksum: #{numbers}"
					response = RestClient.get(BASE_URL + '/checksum')
					body = JSON.parse(response.body)
					assert_equal body["status"], 'OK'
					checksum = checksum + body['body'].join
				when 'C'
					puts "Clear: #{numbers}"
					response = RestClient.delete(BASE_URL)
					assert_equal JSON.parse(response.body)["status"], 'OK'
				when 'A'
					puts "Append: #{numbers}"
					response = RestClient.post(BASE_URL+'/'+numbers, "" , content_type: 'application/json')
					assert_equal JSON.parse(response.body)["status"], 'OK'
				else
					puts "Command not recognised: #{command}"
			end
		rescue RestClient::InternalServerError => e
			binding.pry
		end

		puts checksum
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