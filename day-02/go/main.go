package main

import (
	"log"
	"os"
)

func main() {
	input, err := os.ReadFile("../input.txt")
	if err != nil {
		log.Fatal(err)
		return
	}

	log.Println(one(string(input)))
	log.Println(two(string(input)))
}
