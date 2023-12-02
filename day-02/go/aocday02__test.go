package main

import (
	"os"
	"testing"
)

func TestOne(t *testing.T) {
	input, err := os.ReadFile("../example.txt")
	if err != nil {
		t.Errorf("os.ReadFile() = %q, want nil", err)
	}

	want := 8
	got := one(string(input))
	if got != want {
		t.Errorf("one(%q) = %d, want %d", input, got, want)
	}
}

func TestTwo(t *testing.T) {
	input, err := os.ReadFile("../example.txt")
	if err != nil {
		t.Errorf("os.ReadFile() = %q, want nil", err)
	}

	want := 2286
	got := two(string(input))
	if got != want {
		t.Errorf("two(%q) = %d, want %d", input, got, want)
	}
}
