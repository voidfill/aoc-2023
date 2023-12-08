require "./lib.cr"
require "spec"

describe "Example input" do
	describe "one" do
		input = File.read("../example.txt") 
		it "should return 6592" do
			one(input).should eq 6592
		end
	end

	describe "two" do
		input = File.read("../example.txt") 
		it "should return 6839" do
			two(input).should eq 6839
		end
	end
end

