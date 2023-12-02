package main

import (
	"strconv"
	"strings"
)

var inBagRed = 12
var inBagGreen = 13
var inBagBlue = 14

func one(input string) int {
	acc := 0

	for _, line := range strings.Split(input, "\n") {
		invalid := false

		for _, draw := range strings.Split(strings.Split(line, ": ")[1], "; ") {
			for _, cubes := range strings.Split(draw, ", ") {
				split := strings.Split(cubes, " ")
				num, _ := strconv.Atoi(split[0]) // this should never fail
				if (split[1] == "red" && num > inBagRed) || (split[1] == "green" && num > inBagGreen) || (split[1] == "blue" && num > inBagBlue) {
					invalid = true
					break
				}
			}
		}

		if !invalid {
			num, _ := strconv.Atoi(strings.Split(strings.Split(line, " ")[1], ":")[0])
			acc += num
		}
	}

	return acc
}

func two(input string) int {
	acc := 0

	for _, line := range strings.Split(input, "\n") {
		minRed := 0
		minGreen := 0
		minBlue := 0

		for _, draw := range strings.Split(strings.Split(line, ": ")[1], "; ") {
			for _, cubes := range strings.Split(draw, ", ") {
				split := strings.Split(cubes, " ")
				num, _ := strconv.Atoi(split[0])
				if split[1] == "red" && num > minRed {
					minRed = num
				} else if split[1] == "green" && num > minGreen {
					minGreen = num
				} else if split[1] == "blue" && num > minBlue {
					minBlue = num
				}
			}
		}

		acc += minRed * minGreen * minBlue
	}

	return acc
}
