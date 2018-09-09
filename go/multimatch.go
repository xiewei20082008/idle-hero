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
	opt, _ := strconv.ParseFloat(os.Args[7],64)
	gap, _ := strconv.Atoi(os.Args[8])


	imgFile, _ := os.Open(imgName)
	defer imgFile.Close()
	img, _ := png.Decode(imgFile)

	patternFile, _ := os.Open(patternName)
	defer patternFile.Close()
	pattern, _ := png.Decode(patternFile)

	points := cv.MatchWithOptMulti(img, pattern, x1, y1, x2, y2, opt, gap, true)
	for _, i := range points {
		fmt.Printf("%v,%v,%v|", i.Sim, i.X, i.Y)
	}
}
