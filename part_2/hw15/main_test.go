package main

import (
	"math"
	"testing"
)

func Test_convertToFt(t *testing.T) {

	type args struct {
		input float64
	}

	type testcase struct {
		name string
		args args
		want float64
	}

	var tests = []testcase{
		{"test_correct", args{1}, 3.280840},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := convertToFt(tt.args.input); math.Round(got) != math.Round(tt.want) {
				t.Errorf("convertToFt() = %v, want %v", got, tt.want)
			}
		})
	}
}
