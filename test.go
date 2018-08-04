package main

import (
	"errors"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"os"
)

var GAP = 16
var DEBUG = false

func abs(n int) int {
	if n < 0 {
		return -n
	}
	return n
}

func absOmitTrival(n int) int {
	if n < 0 {
		n = -n
	}
	if n < 32 {
		return 0
	}
	return n
}

func findFirstValidPoint(img image.Image) (int, int, error) {
	width := img.Bounds().Dx()
	height := img.Bounds().Dy()
	for i := 0; i < width; i++ {
		for j := 0; j < height; j++ {
			_, _, _, a := img.At(i, j).RGBA()
			if a != 0 {
				return i, j, nil
			}
		}
	}
	return 0, 0, errors.New("no first valid point")
}

func rgbaModel(c color.Color) (int, int, int, int) {
	r, g, b, a := c.RGBA()
	return (int)(r >> 8), (int)(g >> 8), (int)(b >> 8), (int)(a >> 8)
}

func isColorSame(c1 color.Color, c2 color.Color, gap int) bool {
	r1, g1, b1, _ := rgbaModel(c1)
	r2, g2, b2, _ := rgbaModel(c2)
	if abs(r1-r2) < gap && abs(g1-g2) < gap && abs(b1-b2) < gap {
		return true
	}
	return false
}

func calDiff(img, pattern image.Image, x, y int) (float64, error) {
	width := pattern.Bounds().Dx()
	height := pattern.Bounds().Dy()
	sum := 0
	validPointNum := 0
	for i := 0; i < width; i++ {
		for j := 0; j < height; j++ {
			patternR, patternG, patternB, patternA := rgbaModel(pattern.At(i, j))
			if patternA == 0 {
				continue
			}
			// fmt.Println(patternR, patternG, patternB)
			imgX := i + x
			imgY := j + y
			imgR, imgG, imgB, _ := rgbaModel(img.At(imgX, imgY))
			// fmt.Println(imgR, imgG, imgB)
			validPointNum++
			t := absOmitTrival(patternR-imgR) + absOmitTrival(patternG-imgG) + absOmitTrival(patternB-imgB)
			sum += t
		}
	}
	return float64(sum) / (float64(validPointNum) * 3.0 * 255.0), nil
}

func match(img, pattern image.Image, x1, y1, x2, y2 int) (float64, error) {
	patternDx := pattern.Bounds().Dx()
	patternDy := pattern.Bounds().Dy()
	imgDx := x2
	imgDy := y2
	referX, referY, _ := findFirstValidPoint(pattern)
	referColor := pattern.At(referX, referY)
	diff := 1.0
	targetX, targetY := 0, 0
	for i := x1; i+patternDx <= imgDx; i++ {
		for j := y1; j+patternDy <= imgDy; j++ {
			if !isColorSame(referColor, img.At(i+referX, j+referY), GAP) {
				continue
			}
			diffNow, _ := calDiff(img, pattern, i, j)
			if diffNow < 0.05 {
				return diffNow, nil
			}
			if diffNow < diff {
				targetX, targetY = i, j
				diff = diffNow
			}
		}
	}
	if DEBUG {
		fmt.Printf("match at %v, %v\n", targetX, targetY)
	}
	return diff, nil
}

func completeMatch(img, pattern image.Image) (float64, error) {
	imgDx := img.Bounds().Dx()
	imgDy := img.Bounds().Dy()
	return match(img, pattern, 0, 0, imgDx, imgDy)
}

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
			similarity, _ := match(img, pattern, vi, vj, vi+picSizeX, vj+picSizeY)
			if similarity >= 0.05 {
				continue
			}
			similarity, _ = match(img, coin, coinX[i], coinY[j], coinX[i]+coinSizeX, coinY[j]+coinSizeY)
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
	fileCoin, _ := os.Open("coin1.png")
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
