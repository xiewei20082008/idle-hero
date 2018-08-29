package cv

import (
	"errors"
	"fmt"
	"image"
	"image/color"
	"image/draw"
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

func CleanPixel(img image.Image, x, y int) {
	r, g, b, _ := rgbaModel(img.At(x, y))

	c := color.RGBA{uint8(r), uint8(g), uint8(b), uint8(0)}
	img.(draw.Image).Set(x, y, c)
}

func isColorSame(c1 color.Color, c2 color.Color, gap int) bool {
	r1, g1, b1, _ := rgbaModel(c1)
	r2, g2, b2, _ := rgbaModel(c2)
	if abs(r1-r2) < gap && abs(g1-g2) < gap && abs(b1-b2) < gap {
		return true
	}
	return false
}

func isOverLadder(c1, c2 color.Color) bool {
	return !isColorSame(c1, c2, 16)
}

func GetLadderDiff(img image.Image) ([][]bool, [][]bool) {
	dx := img.Bounds().Dx()
	dy := img.Bounds().Dy()

	var ladder_1 [][]bool
	var ladder_2 [][]bool

	for i := 0; i < dx; i++ {
		tmp := make([]bool, dy-1)
		for j := 0; j < dy-1; j++ {
			tmp[j] = isOverLadder(img.At(i, j), img.At(i, j+1))
			// fmt.Printf("%v,%v to %v,%v ladder == %v", i, j, i, j+1, tmp[j])
		}
		ladder_1 = append(ladder_1, tmp)
	}

	for i := 0; i < dx-1; i++ {
		tmp := make([]bool, dy)
		for j := 0; j < dy; j++ {
			tmp[j] = isOverLadder(img.At(i, j), img.At(i+1, j))
			// fmt.Printf("%v,%v to %v,%v ladder == %v", i, j, i+1, j, tmp[j])
		}
		ladder_2 = append(ladder_2, tmp)
	}
	return ladder_1, ladder_2
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

func Match(img, pattern image.Image, x1, y1, x2, y2 int) (float64, int, int) {
	return MatchWithOpt(img, pattern, x1, y1, x2, y2, 0.08)
}

func MatchWithOpt(img, pattern image.Image, x1, y1, x2, y2 int, opt float64) (float64, int, int) {
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
			if diffNow <= opt {
				return diffNow, i, j
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
	return diff, targetX, targetY
}

func CompleteMatch(img, pattern image.Image) (float64, int, int) {
	imgDx := img.Bounds().Dx()
	imgDy := img.Bounds().Dy()
	return Match(img, pattern, 0, 0, imgDx, imgDy)
}
