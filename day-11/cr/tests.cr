require "./lib.cr"
require "spec"

describe "Example input" do
	describe "one" do
		input = File.read("../example.txt") 
		it "should return 374" do
			sol(input, 2).should eq 374
		end
	end

	describe "two" do
		input = File.read("../example.txt") 
		it "should return 2" do
			sol(input, 100).should eq 8410
		end
	end
end

