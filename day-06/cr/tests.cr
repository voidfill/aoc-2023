require "./lib.cr"
require "spec"

describe "Example input" do
	describe "one" do
		input = File.read("../example.txt") 
		it "should return 288" do
			one(input).should eq 288
		end
	end

	describe "two" do
		input = File.read("../example.txt") 
		it "should return 46" do
			two(input).should eq 71503
		end
	end
end

