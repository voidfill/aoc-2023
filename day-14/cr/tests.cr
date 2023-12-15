require "./lib.cr"
require "spec"

describe "Example input" do
	describe "one" do
		input = File.read("../example.txt") 
		it "should return 136" do
			one(input).should eq 136
		end
	end

	describe "two" do
		input = File.read("../example.txt") 
		it "should return 64" do
			two(input).should eq 64
		end
	end
end

