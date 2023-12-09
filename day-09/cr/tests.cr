require "./lib.cr"
require "spec"

describe "Example input" do
	describe "one" do
		input = File.read("../example.txt") 
		it "should return 114" do
			one(input).should eq 114
		end
	end

	describe "two" do
		input = File.read("../example.txt") 
		it "should return 2" do
			two(input).should eq 2
		end
	end
end

