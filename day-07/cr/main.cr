require "log"
require "./lib"

input = File.read("../input.txt")

Log.info { "One: #{one(input)}" }
Log.info { "Two: #{two(input)}" }
