package main

import (
	"errors"
	"fmt"
)

func convertToFt(input float64) float64 {
	return input / 0.3048
}

func minElem(values []int) (min int, e error) {
	if len(values) == 0 {
		return 0, errors.New("cannot detect a minimum value in an empty slice")
	}

	min = values[0]
	for _, v := range values {
		if v < min {
			min = v
		}
	}

	return min, nil
}

func main() {
	fmt.Println("Enter a number")
	var inputNumber float64

	_, err := fmt.Scanf("%f", &inputNumber)

	if err != nil {
		fmt.Print("Something goes wrong: ", err)
		return
	}

	fmt.Printf("Foot %f meters = %f ft\n", inputNumber, convertToFt(inputNumber))

	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}

	min, err := minElem(x)
	fmt.Printf("Min value %d\n", min)

	intMod3 := 3
	for intMod3 < 100 {
		fmt.Printf("%d ", intMod3)
		intMod3 += 3
	}
}
