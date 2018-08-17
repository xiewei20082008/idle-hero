package main

import (
	"fmt"
	"image"
	"image/png"
	"os"

	"./cv"
)

var DEBUG = false

type result struct {
	pos    int
	isCoin bool
}

func checkExist(img, pattern, coin image.Image) []result {
	var results []result
	picX := [4]int{473, 752, 1033, 1317}
	picY := [2]int{541, 794}
	picSizeX, picSizeY := 124, 123

	coinX := [4]int{441, 724, 1004, 1286}
	coinY := [2]int{690, 949}
	coinSizeX, coinSizeY := 66, 53

	index := -1

	for i, vi := range picX {
		for j, vj := range picY {
			index++
			similarity, _, _ := cv.Match(img, pattern, vi, vj, vi+picSizeX, vj+picSizeY)
			// fmt.Printf("index %v similarity is %v\n", index, similarity)
			if similarity >= 0.08 {
				continue
			}
			similarity, _, _ = cv.Match(img, coin, coinX[i], coinY[j], coinX[i]+coinSizeX, coinY[j]+coinSizeY)
			if DEBUG {
				fmt.Printf("Find pattern in position %v\n", index)
				fmt.Printf("Coin similarity is %v\n", similarity)
			}
			if similarity < 0.08 {
				results = append(results, result{index, true})
			} else {
				results = append(results, result{index, false})
			}
		}
	}
	return results
}

func main() {
	fileCoin, _ := os.Open("/sdcard/go/coin1.png")
	imgCoin, _ := png.Decode(fileCoin)

	file1, _ := os.Open(os.Args[1])
	file2, _ := os.Open(os.Args[2])
	defer file1.Close()
	defer file2.Close()
	img1, _ := png.Decode(file1)
	img2, _ := png.Decode(file2)

	results := checkExist(img1, img2, imgCoin)
	for _, i := range results {
		fmt.Printf("%v %v|", i.pos, i.isCoin)
	}
}
