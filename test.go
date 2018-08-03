package main

import (
	"errors"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"os"
)

var GAP = 10

func abs(n int) int {
	if n < 0 {
		return -n
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
			t := abs(patternR-imgR) + abs(patternG-imgG) + abs(patternB-imgB)
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
	for i := x1; i+patternDx <= imgDx; i++ {
		for j := y1; j+patternDy <= imgDy; j++ {
			if !isColorSame(referColor, img.At(i+referX, j+referY), GAP) {
				continue
			}
			fmt.Println("find the same reference point")
			fmt.Printf("from %v, %v to %v, %v\n", referX, referY, i+referX, j+referY)
			diffNow, _ := calDiff(img, pattern, i, j)
			fmt.Printf("diff now is %v\n", diffNow)
			if diffNow < diff {
				diff = diffNow
			}
		}
	}
	return diff, nil
}

func completeMatch(img, pattern image.Image) (float64, error) {
	imgDx := img.Bounds().Dx()
	imgDy := img.Bounds().Dy()
	return match(img, pattern, 0, 0, imgDx, imgDy)
}

func main() {
	file1, _ := os.Open("1.png")
	file2, _ := os.Open("arena.png")
	defer file1.Close()
	defer file2.Close()
	img1, _ := png.Decode(file1)
	img2, _ := png.Decode(file2)
	fmt.Println(findFirstValidPoint(img2))
	// fmt.Println(calDiff(img1, img2, 0, 0))
	fmt.Println(completeMatch(img1, img2))
}
