require "log"
require "./lib"

input = File.read("../input.txt")

Log.info { "One: #{sol(input, 2.to_i64)}" }
Log.info { "Two: #{sol(input, 1000000.to_i64)}" }
