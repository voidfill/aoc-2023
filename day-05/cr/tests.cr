require "./lib.cr"
require "spec"

describe "Example input" do
	describe "one" do
		input = File.read("../example.txt") 
		it "should return 35" do
			one(input).should eq 35
		end
	end

	describe "two" do
		input = File.read("../example.txt") 
		it "should return 46" do
			two(input).should eq 46
		end
	end
end

