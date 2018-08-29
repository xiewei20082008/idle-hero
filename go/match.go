package main

import (
	"fmt"
	"image/png"
	"os"
	"strconv"

	"./cv"
)

func main() {
	imgName := os.Args[1]
	patternName := os.Args[2]
	x1, _ := strconv.Atoi(os.Args[3])
	y1, _ := strconv.Atoi(os.Args[4])
	x2, _ := strconv.Atoi(os.Args[5])
	y2, _ := strconv.Atoi(os.Args[6])

	imgFile, _ := os.Open(imgName)
	defer imgFile.Close()
	img, _ := png.Decode(imgFile)

	patternFile, _ := os.Open(patternName)
	defer patternFile.Close()
	pattern, _ := png.Decode(patternFile)

	sim, x, y := cv.MatchWithOpt(img, pattern, x1, y1, x2, y2, 0.0)
	fmt.Printf("%v,%v,%v|", sim, x, y)

}
